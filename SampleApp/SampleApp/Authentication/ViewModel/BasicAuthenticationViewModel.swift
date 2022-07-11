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
import AlfrescoAuth
import AlfrescoContent

protocol BasicAuthViewModelDelegate: class {
    func logInSuccessful(with credential: BasicAuthCredential)
    func logInFailed(with error: APIError)
}

class BasicAuthenticationViewModel {
    var authenticationService: AuthenticationService?
    weak var delegate: BasicAuthViewModelDelegate?

    func authenticate(username: String, password: String) {
        let basicAuthCredential = BasicAuthCredential(username: username, password: password)
        authenticationService?.basicAuthentication(with: basicAuthCredential, handler: { [weak self] (result) in
            guard let sSelf = self else { return }
            switch result {
            case .success:
                DispatchQueue.main.async {

                    if let parameters = sSelf.authenticationService?.parameters {
                        let basePath = "\(parameters.fullHostnameURL)/\(parameters.serviceDocument)/api/-default-/public"
                        AlfrescoContentAPI.basePath = basePath
                        AlfrescoProcessAPI.basePath = "\(parameters.fullHostnameURL)"
                        sSelf.delegate?.logInSuccessful(with: basicAuthCredential)
                    }
                }
                
            case .failure(let error):
                DispatchQueue.main.async {
                    sSelf.delegate?.logInFailed(with: error)
                }
            }
        })
    }
}
