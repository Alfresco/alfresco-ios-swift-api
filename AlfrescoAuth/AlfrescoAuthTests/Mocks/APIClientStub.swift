//
//  APIClientStub.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 15/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
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
