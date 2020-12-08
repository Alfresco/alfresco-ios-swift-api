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
import AlfrescoCore

class RefreshTokenPresenter: NSObject, NetworkServiceProtocol {
    weak var authDelegate: AlfrescoAuthDelegate?
    var apiClient: APIClientProtocol
    var configuration: AuthConfiguration

    init(configuration: AuthConfiguration) {
        self.configuration = configuration
        self.apiClient = APIClient(with: configuration.baseUrl)
    }

    func executeRefresh(_ credential: AlfrescoCredential) {
        requestToken(with: credential) { [weak self] (result) in
            guard let sSelf = self else { return } 
            DispatchQueue.main.async {
                sSelf.authDelegate?.didReceive(result: result)
            }
        }
    }

    func requestToken(with credential: AlfrescoCredential,
                      completion: @escaping (Result<AlfrescoCredential?, APIError>) -> Void) {
        if let refreshToken = credential.refreshToken {
            _ = apiClient.send(GetAlfrescoCredential(refreshToken: refreshToken,
                                                     configuration: configuration),
                               completion: { (result) in
                completion(result)
            })
        } else {
            completion(.failure(APIError(domain: Bundle.main.bundleName ?? "AlfrescoAuth",
                                         code: ModuleErrorType.errorRefreshTokenNil.code,
                                         message: errorRefreshTokenNil)))
        }
    }
}
