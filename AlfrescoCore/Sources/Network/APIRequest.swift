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
    - Remark: The specified type will be used in the  JSON transformation of the request response.
     Implementers of this protocol must provide property decoders to support obect mapping.
     */
    associatedtype Response: Decodable

    // Path component of the request to be appended to the base url
    var path: String { get }
    // HTTP verb of the request
    var method: HttpMethod { get }
    // Request header parameters
    var headers: [String: String] { get }
    // Additional request parameters
    var parameters: [String: String] { get }
}
