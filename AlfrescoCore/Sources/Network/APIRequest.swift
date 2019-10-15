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


/// Protocol declaration for request objects
public protocol APIRequest: Encodable {
    /**
     Object type for the expected response.
    - Remark: The specified type will be used in the  JSON transformation of the request response. Implementers of this protocol must provide
     property decoders to support obect mapping.
     */
    associatedtype Response: Decodable
    
    // Path component of the request to be appended to the base url
    var path: String { get }
    // HTTP verb of the request
    var method: HttpMethod { get }
    // Request header parameters
    var headers: [String: ContentType] { get }
    // Additional request parameters
    var parameters: [String: String] { get }
}
