//
//  AlfrescoApiClient.swift
//  AlfrescoCore
//
//  Created by Florin Baincescu on 10/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public typealias ResultCallback<Value> = (Result<Value, Error>) -> Void

public protocol APIClientProtocol {
    var baseURL: URL? { get }
    init(with base: String)
    
    func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) -> URLSessionDataTask?
}

public class APIClient: APIClientProtocol {
    private let session = URLSession(configuration: .default)
    public var baseURL: URL?
    
    public required init(with base: String) {
        self.baseURL = URL(string: base)
    }

    public func send<T: APIRequest>(_ request: T, completion: @escaping ResultCallback<T.Response>) -> URLSessionDataTask? {
        if let urlRequest = endPoint(for: request) {
            let task = session.dataTask(with: urlRequest) { (data, response, error) in
                guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                    completion(.failure(self.createError(code: 400, message: "Request unavailable.")))
                    return
                }
                guard (200 ... 299) ~= response.statusCode else {
                    if let errorDictionary = data.convertToDictionary() {
                        completion(.failure(self.createError(code: 400, message: errorDictionary["error_description"] as! String)))
                    } else {
                        completion(.failure(self.createError(code: 400, message: "Converstion to dictonary failed.")))
                    }
                    return
                }
                do {
                    let model = try JSONDecoder().decode(T.Response.self, from: data)
                    completion(.success(model))
                } catch {
                    completion(.failure(error))
                }
            }
            task.resume()
            return task
        } else {
            completion(.failure(self.createError(code: 400, message: "Request unavailable.")))
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
    
    private func createError(domain: String = "", code: NSInteger, message: String) -> NSError {
        let error = NSError(domain: domain,
                            code: code,
                            userInfo: [NSLocalizedDescriptionKey: message])
        return error
    }
}
