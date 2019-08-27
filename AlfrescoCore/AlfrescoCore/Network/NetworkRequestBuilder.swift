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
    
    func request(method: HttpMethod, path: String, headerFields: [String: String]? = nil, parameters: [String: String]? = nil) -> URLRequest? {
        var request: URLRequest?
        if let url = URL(string: path, relativeTo: baseURL) {
            request = URLRequest(url: url)
            request?.httpMethod = method.rawValue
            
            if let httpHeaderFields = headerFields {
                for (key, value) in httpHeaderFields {
                    request?.setValue(value, forHTTPHeaderField: key)
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
}
