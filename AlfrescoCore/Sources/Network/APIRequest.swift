//
//  APIRequest.swift
//  AlfrescoCore
//
//  Created by Florin Baincescu on 10/09/2019.
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
    case json = "application/json"
}

public protocol APIRequest: Encodable {
    associatedtype Response: Decodable
    
    var path: String { get }
    var method: HttpMethod { get }
    var headers: [String: ContentType] { get }
    var parameters: [String: String] { get }
}
