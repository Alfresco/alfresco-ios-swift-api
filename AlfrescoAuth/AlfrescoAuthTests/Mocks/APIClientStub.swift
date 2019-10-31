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

class APIClientStub: APIClientProtocol {
    var baseURL: URL?
    var successResponse: Bool = true
    
    required init(with base: String, session: URLSessionProtocol) {
        self.baseURL = URL(string: base)
    }
    
    func send<T>(_ request: T, completion: @escaping (Result<T.Response, APIError>) -> Void) -> URLSessionDataTask? where T : APIRequest {
        if successResponse {
            let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
            completion(.success(alfrescoCredential as! T.Response))
        } else {
            let error = APIError(domain: "Tests")
            completion(.failure(error))
        }
        return nil
    }
}
