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
@testable import AlfrescoAuth

enum APICLientStubResponse {
    case validCredential
    case validResponseCode
    case error
}

class APIClientStub: APIClientProtocol {
    var baseURL: URL?
    var responseType: APICLientStubResponse = .validCredential
    
    required init(with base: String, session: URLSessionProtocol) {
        self.baseURL = URL(string: base)
    }
    
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, APIError>) -> Void) -> URLSessionDataTask? where T : APIRequest {
        switch responseType {
        case .validCredential:
            let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
            completion(.success(alfrescoCredential as! T.Response))
        case .validResponseCode:
            let statusCodeResponse = StatusCodeResponse.init(responseCode: 200)
            completion(.success(statusCodeResponse as! T.Response))
        case .error:
            let error = APIError(domain: "Tests")
            completion(.failure(error))
        }
        
        return nil
    }
}
