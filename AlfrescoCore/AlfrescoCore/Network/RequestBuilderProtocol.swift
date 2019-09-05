//
//  RequestBuilder.swift
//  AlfrescoCore
//
//  Created by Silviu Odobescu on 22/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public enum HttpMethod: String {
    case get = "GET"
    case head = "HEAD"
    case delete = "DELETE"
    case post = "POST"
    case put = "PUT"
}

public enum ContentType: String {
    case urlencoded = "application/x-www-form-urlencoded"
}

public enum GrantType: String {
    case password = "password"
}

public protocol RequestBuilderProtocol {
    var baseURL: URL? { get set }
    
    func request(method: HttpMethod, path: String, headerFields: [String: ContentType]?, parameters: [String: String]?) -> URLRequest?
    
    func start(request: URLRequest?, completionHandler: @escaping (Result<[String: Any], Error>) -> Void) -> URLSessionDataTask?
}
