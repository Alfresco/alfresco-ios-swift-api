//
//  APIErrorMockedObjects.swift
//  AlfrescoCoreTests
//
//  Created by Emanuel Lupu on 15/10/2019.
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

class MockURLSessionWithInvalidDataAndResponse: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        completionHandler(nil, nil, nil)
        
        return URLSession.init(configuration: .default).dataTask(with: URL(string: TestData.testAPIRequestPath)!)
    }
}

class MOCKURLSessionWithSuccessfullResponse: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        do {
            let data = try JSONSerialization.data(withJSONObject: TestData.response, options: .prettyPrinted)
            let response = HTTPURLResponse(url: URL(string: TestData.testAPIRequestPath)!, statusCode: StatusCodes.Code200OK.code, httpVersion: nil, headerFields: nil)
            completionHandler(data, response, nil)
        } catch {}
        return URLSession.init(configuration: .default).dataTask(with: URL(string: TestData.testAPIRequestPath)!)
    }
}

class MOCKURLSessionWithInvalidResponse: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        let data = TestData.invalidResponse.data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: TestData.testAPIRequestPath)!, statusCode: StatusCodes.Code200OK.code, httpVersion: nil, headerFields: nil)
        completionHandler(data, response, nil)
        return URLSession.init(configuration: .default).dataTask(with: URL(string: TestData.testAPIRequestPath)!)
    }
}

class MOCKURLSessionWithInvalidStatusCodeResponse: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        do {
            let data = try JSONSerialization.data(withJSONObject: [:], options: .prettyPrinted)
            let response = HTTPURLResponse(url: URL(string: TestData.testAPIRequestPath)!, statusCode: StatusCodes.Code400BadRequest.code, httpVersion: nil, headerFields: nil)
            completionHandler(data, response, nil)
        } catch {}
        return URLSession.init(configuration: .default).dataTask(with: URL(string: TestData.testAPIRequestPath)!)
    }
}
