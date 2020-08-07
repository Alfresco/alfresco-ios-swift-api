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
import AlfrescoAuth
import AlfrescoContent

protocol SSOAuthenticationViewModelDelegate: class {
    func logInFailed(with error: APIError)
    func logInSuccessful(with credential: AlfrescoCredential)
}

class SSOAuthenticationViewModel {
    var authenticationService: AuthenticationService?
    weak var delegate: SSOAuthenticationViewModelDelegate?

    func login(in viewController: UIViewController) {
        authenticationService?.aimsAuthentication(on: viewController, delegate: self)
    }
}

extension SSOAuthenticationViewModel: AlfrescoAuthDelegate {
    func didReceive(result: Result<AlfrescoCredential, APIError>, session: AlfrescoAuthSession?) {
        switch result {
        case .success(let credential):
            DispatchQueue.main.async { [weak self] in
                guard let sSelf = self else { return }

                sSelf.authenticationService?.session = session

                if let parameters = sSelf.authenticationService?.parameters {
                    let basePath = "\(parameters.fullContentURL)/\(parameters.serviceDocument)/api/-default-/public"
                    AlfrescoContentAPI.basePath = basePath
                }
                sSelf.delegate?.logInSuccessful(with: credential)
            }
        case .failure(let error):
            DispatchQueue.main.async { [weak self] in
                guard let sSelf = self else { return }
                sSelf.delegate?.logInFailed(with: error)
            }
        }
    }

    func didLogOut(result: Result<Int, APIError>) {}
}

