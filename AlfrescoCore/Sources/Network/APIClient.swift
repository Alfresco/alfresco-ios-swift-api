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

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,
                  completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

public protocol APIClientProtocol {
    /// Base URL based on which request objects will set custom paths.
    var baseURL: URL? { get }

    /** Designated initializer
    - Parameter base: Base URL adress used to generate requests
    - Parameter session: Session object on which the requests should be performed
    */
    init(with base: String, session: URLSessionProtocol)

    /** Asynchronously executes a request and return the result back the result via a completion block.
    - Parameter request: Request object to be executed
    - Parameter completion: Completion block containing the response object and an optional error parameter
    */
    func send<T: APIRequest>(_ request: T,
                             completion: @escaping ResultCallback<T.Response>) -> URLSessionDataTask?
}

extension URLSession: URLSessionProtocol { }

public typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
public typealias ResultCallback<Value> = (Result<Value?, APIError>) -> Void

public class APIClient: APIClientProtocol {
    private let session: URLSessionProtocol
    private let moduleName = Bundle.main.bundleName ?? "AlfrescoCore"
    public var baseURL: URL?

    public required init(with base: String,
                         session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.baseURL = URL(string: base)
        self.session = session
    }

    public func send<T: APIRequest>(_ request: T,
                                    completion: @escaping ResultCallback<T.Response>) -> URLSessionDataTask? {
        if let urlRequest = endPoint(for: request) {
            let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                guard let sSelf = self else { return }
                if let error = error {
                    completion(.failure(APIError(domain: sSelf.moduleName,
                                                 error: error)))
                    return
                }
                guard let data = data,
                      let response = response as? HTTPURLResponse else {
                    completion(.failure(APIError(domain: sSelf.moduleName,
                                                 code: ModuleErrorType.errorDataTaskResultNil.code,
                                                 message: errorDataTaskResultNil)))
                    return
                }

                guard (StatusCodes.code200OK.code ... StatusCodes.code209IMUsed.code) ~= response.statusCode else {
                    do {
                        if let errorDictionary = try data.convertToDictionary() {
                            completion(.failure(APIError(domain: sSelf.moduleName,
                                                         code: response.statusCode,
                                                         userInfo: errorDictionary)))
                        } else {
                            completion(.failure(APIError(domain: sSelf.moduleName,
                                                         code: ModuleErrorType.errorResponseConvertToDictionary.code,
                                                         message: errorResponseConvertToDictionary)))
                        }
                    } catch {
                        completion(.failure(APIError(domain: sSelf.moduleName,
                                                     code:response.statusCode,
                                                     error: error)))
                    }
                    return
                }

                if T.Response.self == Data.self {
                    completion(.success(data as? T.Response))
                } else if T.Response.self == StatusCodeResponse.self {
                    completion(.success(sSelf.statusCodeResponse(T.Response.self,
                                                                 responseCode: response.statusCode)))
                } else {
                    do {
                        let model = try JSONDecoder().decode(T.Response.self,
                                                             from: data)
                        completion(.success(model))
                    } catch {
                        completion(.failure(APIError(domain: sSelf.moduleName,
                                                     error: error)))
                    }
                }
            }
            task.resume()
            return task
        } else {
            completion(.failure(APIError(domain: self.moduleName,
                                         code: ModuleErrorType.errorRequestUnavailable.code,
                                         message: errorRequestUnavailable)))
        }

        return nil
    }

    // MARK: - Private interface

    private func endPoint<T: APIRequest>(for request: T) -> URLRequest? {
        var urlRequest: URLRequest?

        if let url = URL(string: request.path, relativeTo: baseURL) {
            urlRequest = URLRequest(url: url)
            urlRequest?.httpMethod = request.method.rawValue

            for (key, value) in request.headers {
                urlRequest?.setValue(value, forHTTPHeaderField: key)
            }

            switch request.method {
            case .post:
                urlRequest?.httpBody = request.parameters.percentEscaped().data(using: .utf8)
            case .get:
                var urlComponents = URLComponents(string: url.absoluteString)
                if request.parameters.count > 0 {
                    urlComponents?.queryItems = request.parameters.map {
                        URLQueryItem(name: $0, value: $1)
                    }
                }
                urlRequest?.url = urlComponents?.url
            default:
                break
            }
        }
        return urlRequest
    }

    func statusCodeResponse<T>(_ type: T.Type, responseCode: Int) -> T? where T: Decodable {
        return StatusCodeResponse(responseCode: responseCode) as? T
    }
}
