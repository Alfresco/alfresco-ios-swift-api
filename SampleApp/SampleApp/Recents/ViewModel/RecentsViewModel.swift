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

import Foundation
import AlfrescoContent
import AlfrescoAuth

protocol RecentsViewModelDelegate: AnyObject {
    func didLoadRecents()
    func didLogout()
    func didRefreshSession()
}

class RecentsViewModel {
    var authenticationProvider: AuthenticationProviderProtocol?
    var authenticationService: AuthenticationService?

    var ssoCredential: AlfrescoCredential?

    var nodes: [ListNode]?
    weak var delegate: RecentsViewModelDelegate?

    func fetchRecentsList() {
        guard let provider = authenticationProvider else { return }
        AlfrescoContentAPI.customHeaders = provider.authorizationHeader()
        getProcessList()
    }
    
    func getProcessList() {
//        let params = ProcessRequestLinkContent(source: "alfresco-1-adw-contentAlfresco", mimeType: "image/jpeg", sourceId: "d1157240-1b06-4f86-8799-4c2f5fb74e17;1.0@", name: "IMG_20230307_192123733.jpg")
//
//        ProcessAPI.linkContentToProcess(params: params) { data, error in
//            print("*** process content ***", data)
//            print("*** error ***", error)
//        }
        
//        ProcessAPI.checkIfAPSIsEnabled { data, error in
//            print("*** process system properties ***", data)
//            print("*** error ***", error)
//        }
        
//        ProcessAPI.processDefinition(appDefinitionId: "2") { data, error in
//            print("*** process definition ***", data)
//            print("*** error ***", error)
//        }
        
        ProcessAPI.runtimeAppDefinition { data, error in
            print("*** run time app definition ***", data?.data)
            print("*** error ***", error)
        }
    }

    func logout(on viewController: UIViewController) {
        if let credentials = ssoCredential {
            authenticationService?.logOut(onViewController: viewController, lastKnownCredential: credentials, delegate: self)
        } else {
            delegate?.didLogout()
        }
    }

    func refreshSession() {
        authenticationService?.refreshSession(delegate: self)
    }
    
    func loadAdvanceSearchConfiguration() {
//        QueriesAPI.loadAdvanceSearchConfigurations { configuration, error in
//        }
    }
}

extension RecentsViewModel: AlfrescoAuthDelegate {
    func didReceive(result: Result<AlfrescoCredential?, APIError>, session: AlfrescoAuthSession?) {
        switch result {
        case .success(let credential):
            DispatchQueue.main.async { [weak self] in
                guard let sSelf = self else { return }

                if let credential = credential {
                    sSelf.authenticationProvider = AIMSAuthenticationProvider(with: credential)
                }
                sSelf.delegate?.didRefreshSession()
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func didLogOut(result: Result<Int, APIError>, session: AlfrescoAuthSession?) {
        authenticationService?.session = nil
        authenticationProvider = nil
        delegate?.didLogout()
    }
}
