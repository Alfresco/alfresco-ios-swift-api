//
//  AlfrescoApiClient.swift
//  AlfrescoCore
//
//  Created by Florin Baincescu on 10/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskResult) -> URLSessionDataTask
}

public protocol APIClientProtocol {
    var baseURL: URL? { get }
    init(with base: String, session: URLSessionProtocol)
    
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) -> URLSessionDataTask?
}

extension URLSession: URLSessionProtocol { }

public typealias DataTaskResult = (Data?, URLResponse?, Error?) -> Void
public typealias ResultCallback<Value> = (Result<Value, APIError>) -> Void

public class APIClient: APIClientProtocol {
    private let session: URLSessionProtocol
    private let moduleName = Bundle.main.bundleName ?? "AlfrescoCore"
    public var baseURL: URL?
    
    public required init(with base: String, session: URLSessionProtocol = URLSession(configuration: .default)) {
        self.baseURL = URL(string: base)
        self.session = session
    }

    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) -> URLSessionDataTask? {
        if let urlRequest = endPoint(for: request) {
            let task = session.dataTask(with: urlRequest) { [weak self] (data, response, error) in
                guard let sSelf = self else { return }
                if let error = error {
                    completion(.failure(APIError(domain: sSelf.moduleName, error: error)))
                    return
                }
                guard let data = data, let response = response as? HTTPURLResponse else {
                    completion(.failure(APIError(domain: sSelf.moduleName, message: errTryAgain)))
                    return
                }
                guard (200 ... 299) ~= response.statusCode else {
                    do {
                        if let errorDictionary = try data.convertToDictionary() {
                            completion(.failure(APIError(domain: sSelf.moduleName, code: response.statusCode, userInfo: errorDictionary)))
                        } else {
                            completion(.failure(APIError(domain: sSelf.moduleName, code: response.statusCode, message: errTryAgain)))
                        }
                    } catch {
                        completion(.failure(APIError(domain: sSelf.moduleName, error: error)))
                    }
                    return
                }
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(APIError(domain: sSelf.moduleName, error: error)))
                }
            }
            task.resume()
            return task
        } else {
            completion(.failure(APIError(domain: self.moduleName, message: errRequestUnavailable)))
        }
        return nil
    }
    
    //MARK: - Utils
    
    private func endPoint<T: APIRequest>(for request: T) -> URLRequest? {
        var urlRequest: URLRequest?
        
        if let url = URL(string: request.path, relativeTo: baseURL) {
            urlRequest = URLRequest(url: url)
            urlRequest?.httpMethod = request.method.rawValue
            
            for (key, value) in request.headers {
                urlRequest?.setValue(value.rawValue, forHTTPHeaderField: key)
            }
            
            switch request.method {
            case .post:
                urlRequest?.httpBody = request.parameters.percentEscaped().data(using: .utf8)
            case .get:
                var urlComponents = URLComponents(string: url.absoluteString)
                urlComponents?.queryItems = request.parameters.map {
                    URLQueryItem(name: $0, value: $1)
                }
                urlRequest?.url = urlComponents?.url
            default:
                break
            }
        }
        
        return urlRequest
    }
}
