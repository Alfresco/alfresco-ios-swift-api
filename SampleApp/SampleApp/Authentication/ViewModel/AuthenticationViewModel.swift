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

protocol AuthenticationViewModelDelegate: class {
    func authServiceAvailable(for authType: AvailableAuthType)
    func authServiceUnavailable(with error: APIError)
}

class AuthenticationViewModel {
    var authenticationService: AuthenticationService?
    weak var delegate: AuthenticationViewModelDelegate?

    init(with loginService: AuthenticationService?) {
        authenticationService = loginService
    }

    func availableAuthType(for url: String) {
        guard let authParameters = authenticationService?.parameters else { return }
        authParameters.hostname = url
        authenticationService?.update(authenticationParameters: authParameters)
        authenticationService?.availableAuthType(handler: { [weak self] (result) in
            guard let sSelf = self else { return }
            switch result {
            case .success(let authType):
                sSelf.authenticationService?.saveAuthParameters()

                DispatchQueue.main.async {
                    sSelf.delegate?.authServiceAvailable(for: authType)
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    sSelf.delegate?.authServiceUnavailable(with: error)
                }
            }
        })
    }
}
