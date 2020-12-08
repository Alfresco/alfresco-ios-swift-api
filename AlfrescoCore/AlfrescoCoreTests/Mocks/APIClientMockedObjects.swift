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
@testable import AlfrescoCore

class MockURLSessionWithError: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        completionHandler(nil, nil, APIError(domain: "test"))

        let url = URL(string: TestData.testAPIRequestPath)!
        return URLSession.init(configuration: .default).dataTask(with: url)
    }
}

class MockURLSessionWithInvalidDataAndResponse: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        completionHandler(nil, nil, nil)

        let url = URL(string: TestData.testAPIRequestPath)!
        return URLSession.init(configuration: .default).dataTask(with: url)
    }
}

class MOCKURLSessionWithSuccessfullResponse: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        do {
            let data = try JSONSerialization.data(withJSONObject: TestData.response, options: .prettyPrinted)
            let response = HTTPURLResponse(url: URL(string: TestData.testAPIRequestPath)!,
                                           statusCode: StatusCodes.code200OK.code,
                                           httpVersion: nil,
                                           headerFields: nil)
            completionHandler(data, response, nil)
        } catch {}

        let url = URL(string: TestData.testAPIRequestPath)!
        return URLSession.init(configuration: .default).dataTask(with: url)
    }
}

class MOCKURLSessionWithInvalidResponse: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        let data = TestData.invalidResponse.data(using: .utf8)
        let response = HTTPURLResponse(url: URL(string: TestData.testAPIRequestPath)!,
                                       statusCode: StatusCodes.code200OK.code,
                                       httpVersion: nil,
                                       headerFields: nil)
        completionHandler(data, response, nil)
        return URLSession.init(configuration: .default).dataTask(with: URL(string: TestData.testAPIRequestPath)!)
    }
}

class MOCKURLSessionInvalidStatusCodeResponse: URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTask {
        do {
            let data = try JSONSerialization.data(withJSONObject: [:], options: .prettyPrinted)
            let response = HTTPURLResponse(url: URL(string: TestData.testAPIRequestPath)!,
                                           statusCode: StatusCodes.code400BadRequest.code,
                                           httpVersion: nil,
                                           headerFields: nil)
            completionHandler(data, response, nil)
        } catch {}

        let url = URL(string: TestData.testAPIRequestPath)!
        return URLSession.init(configuration: .default).dataTask(with: url)
    }
}
