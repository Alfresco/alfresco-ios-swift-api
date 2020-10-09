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
import UIKit
import AlfrescoCore

enum InputType: String {
    case username = "Username"
    case password = "Password"
}

class AuthBasicPresenter: NSObject, NetworkServiceProtocol {
    var authDelegate: AlfrescoAuthDelegate? = nil
    var apiClient: APIClientProtocol
    var configuration: AuthConfiguration
    
    init(configuration: AuthConfiguration) {
        self.configuration = configuration
        self.apiClient = APIClient(with: configuration.baseUrl)
    }
    
    func verify(string: String?, type: InputType) -> String? {
        guard let string = string else {
            switch type {
            case .username:
                self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, code: ModuleErrorType.errorUsernameNotEmpty.code, message: errorUsernameNotEmpty)))
            case .password:
                self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, code: ModuleErrorType.errorPasswordNotEmpty.code, message: errorPasswordNotEmpty)))
            }
            
            return nil
        }
        
        let stringTrim = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if stringTrim.isEmpty {
            switch type {
            case .username:
                self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, code: ModuleErrorType.errorUsernameNotEmpty.code, message: errorUsernameNotEmpty)))
            case .password:
                self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, code: ModuleErrorType.errorPasswordNotEmpty.code, message: errorPasswordNotEmpty)))
            }
            return nil
        }
        return string
    }

    func execute(username: String?, password: String?) {
        let username = verify(string: username, type: .username)
        let password = verify(string: password, type: .password)
        if let username = username, let password = password {
            requestToken(with: username, and: password) { [weak self] (result) in
                guard let sSelf = self else { return }
                DispatchQueue.main.async {
                    sSelf.authDelegate?.didReceive(result: result)
                }
            }
        }
    }
    
    func requestToken(with username: String, and password: String, completion: @escaping (Result<AlfrescoCredential, APIError>) -> Void) {
        _ = apiClient.send(GetAlfrescoCredential(username: username, password: password, configuration: configuration)) { (result) in
            completion(result)
        }
    }
}
