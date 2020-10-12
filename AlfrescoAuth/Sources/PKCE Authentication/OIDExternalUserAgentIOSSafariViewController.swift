//
// Copyright (C) 2005-2020 Alfresco Software Limited.
//
// This file is part of the Alfresco Content Mobile iOS App.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import SafariServices
import AppAuth

protocol OIDSafariViewControllerFactory {
    func safariViewControllerWithURL(url: URL) -> SFSafariViewController
}

/**
 A special-case iOS external user-agent that always uses \SFSafariViewController (on iOS 9+).
 Most applications should use the more generic @c OIDExternalUserAgentIOS to get the default
 AppAuth user-agent handling with the benefits of Single Sign-on (SSO) for all supported versions
 of iOS.
 */
class OIDDefaultSafariViewControllerFactory: NSObject, OIDSafariViewControllerFactory {
    func safariViewControllerWithURL(url: URL) -> SFSafariViewController {
        return SFSafariViewController.init(url: url)
    }
}

class OIDExternalUserAgentIOSSafariViewController: NSObject {
    static var viewControllerFactory: OIDSafariViewControllerFactory?

    var presentingViewController: UIViewController = UIViewController.init()
    var externalUserAgentFlowInProgress: Bool = false
    weak var session: OIDExternalUserAgentSession?
    weak var safariVC: SFSafariViewController?

    class func safariViewControllerFactory() -> OIDSafariViewControllerFactory {
        if let safariViewControllerFactory = viewControllerFactory {
            return safariViewControllerFactory
        }
        viewControllerFactory = OIDDefaultSafariViewControllerFactory.init()
        return viewControllerFactory!
    }

    class func setSafariViewControllerFactory(factory: OIDSafariViewControllerFactory) {
        viewControllerFactory = factory
    }

    @available(*, unavailable, message: "Please use initWithPresentingViewController")
    override init() {
        fatalError("Unavailable. Please use initWithPresentingViewController")
    }

    /**
     The designated initializer.
     - Parameter presentingViewController: The view controller from which to present the `SFSafariViewController`.
     */
    required init(presentingViewController: UIViewController) {
        super.init()
        self.presentingViewController = presentingViewController
    }

    func cleanUp() {
        safariVC = nil
        session = nil
        externalUserAgentFlowInProgress = false
    }
}


// MARK: - OIDExternalUserAgent

extension OIDExternalUserAgentIOSSafariViewController: OIDExternalUserAgent {
    func present(_ request: OIDExternalUserAgentRequest,
                 session: OIDExternalUserAgentSession) -> Bool {
        if externalUserAgentFlowInProgress {
            return false
        }
        
        externalUserAgentFlowInProgress = true
        self.session = session
        
        var openedSafari: Bool = false
        let requestURL = request.externalUserAgentRequestURL()
        
        if #available(iOS 9.0, *) {
            let factory = OIDExternalUserAgentIOSSafariViewController.safariViewControllerFactory()
            let safariVC = factory.safariViewControllerWithURL(url: requestURL!)
            safariVC.delegate = self
            self.safariVC = safariVC
            presentingViewController.present(safariVC, animated: true, completion: nil)
            openedSafari = true
        } else {
            openedSafari = UIApplication.shared.canOpenURL(requestURL!)
        }
        
        if !openedSafari {
            self.cleanUp()
            let error = OIDErrorUtilities.error(with: .safariOpenError,
                                                underlyingError: nil,
                                                description: "Unable to open Safari.")
            session.failExternalUserAgentFlowWithError(error)
        }
        
        return openedSafari
    }
    
    func dismiss(animated: Bool, completion: @escaping () -> Void) {
        if !externalUserAgentFlowInProgress {
            // Ignore this call if there is no authorization flow in progress.
            return
        }
        
        guard let safariVC: SFSafariViewController = safariVC else {
            completion()
            self.cleanUp()
            return
        }
        
        self.cleanUp()
        
        if #available(iOS 9.0, *) {
            safariVC.dismiss(animated: true, completion: completion)
        } else {
            completion()
        }
    }
}

// MARK: - SFSafariViewControllerDelegate
extension OIDExternalUserAgentIOSSafariViewController: SFSafariViewControllerDelegate {
    func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        if controller != safariVC {
            // Ignore this call if the safari view controller do not match.
            return
        }
        
        if !externalUserAgentFlowInProgress {
            // Ignore this call if there is no authorization flow in progress.
            return
        }
        
        guard let session = session else { return }
        self.cleanUp()
        let error = OIDErrorUtilities.error(with: .programCanceledAuthorizationFlow,
                                            underlyingError: nil,
                                            description: nil)
        session.failExternalUserAgentFlowWithError(error)
    }
}
