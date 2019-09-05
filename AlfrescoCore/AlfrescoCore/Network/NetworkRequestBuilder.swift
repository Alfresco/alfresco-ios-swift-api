//
//  NetworkRequestBuilder.swift
//  AlfrescoCore
//
//  Created by Silviu Odobescu on 26/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

struct NetworkRequestBuilder: RequestBuilderProtocol {
    var baseURL: URL?
    
    func request(method: HttpMethod, path: String, headerFields: [String: ContentType]? = nil, parameters: [String: String]? = nil) -> URLRequest? {
        var request: URLRequest?
        if let url = URL(string: path, relativeTo: baseURL) {
            request = URLRequest(url: url)
            request?.httpMethod = method.rawValue
            
            if let httpHeaderFields = headerFields {
                for (key, value) in httpHeaderFields {
                    request?.setValue(value.rawValue, forHTTPHeaderField: key)
                }
            }
            
            if let bodyParams = parameters {
                switch method {
                case .post:
                    request?.httpBody = bodyParams.percentEscaped().data(using: .utf8)
                case .get:
                    var urlComponents = URLComponents(string: url.absoluteString)
                    urlComponents?.queryItems = bodyParams.map {
                        URLQueryItem(name: $0, value: $1)
                    }
                    request?.url = urlComponents?.url
                default:
                    break
                    
                }
            }
        }
        
        return request
    }
    
    func start(request: URLRequest?, completionHandler: @escaping (Result<[String: Any], Error>) -> Void) -> URLSessionDataTask? {
        guard let request = request else {
            completionHandler(Result.failure(createError(code: 400, message: "Request unavailable.")))
            return nil
        }
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completionHandler(Result.failure(self.createError(code: 400, message: "Request unavailable.")))
                return
            }
            guard (200 ... 299) ~= response.statusCode else {
                if let errorDictionary = data.convertToDictionary() {
                    completionHandler(Result.failure(self.createError(code: 400, message: errorDictionary["error_description"] as! String)))
                } else {
                    completionHandler(Result.failure(self.createError(code: 400, message: "Converstion to dictonary failed.")))
                }
                return
            }
            if let model = data.convertToDictionary() {
                completionHandler(Result.success(model))
            } else {
                completionHandler(Result.failure(self.createError(code: 400, message: "Converstion to dictonary failed.")))
            }
        }
        task.resume()
        return task
    }
    
    //MARK: - Utils
    
    func createError(domain: String = "", code: NSInteger, message: String) -> NSError {
        let error = NSError(domain: domain,
                            code: code,
                            userInfo: [NSLocalizedDescriptionKey: message])
        return error
    }
}
