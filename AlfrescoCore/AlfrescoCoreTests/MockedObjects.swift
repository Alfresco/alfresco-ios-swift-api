//
//  MockedObjects.swift
//  AlfrescoCoreTests
//
//  Created by Emanuel Lupu on 11/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
@testable import AlfrescoCore

class MockURLSessionWithError: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        completionHandler(nil, nil, APIError(domain:"test"))
        
       return URLSession.init(configuration: .default).dataTask(with: URL(string: TestData.testAPIRequestPath)!)
    }
}

