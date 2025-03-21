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

public struct AuthConfiguration: Encodable, Equatable {
    enum Key: CodingKey {
        case clientID
        case clientSecret
        case baseUrl
        case realm
        case redirectURI
        case audience
    }

    var clientID: String
    var clientSecret: String?
    var baseUrl: String
    var realm: String
    var redirectURI: String?
    var audience: String
    
    public init(baseUrl: String,
                clientID: String,
                realm: String,
                clientSecret: String? = nil,
                redirectURI: String = "", audience: String) {
        self.clientID = clientID
        self.baseUrl = baseUrl
        self.realm = realm
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
        self.audience = audience
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode("clientID", forKey: .clientID)
        try container.encode("clientSecret", forKey: .clientSecret)
        try container.encode("baseUrl", forKey: .baseUrl)
        try container.encode("realm", forKey: .realm)
        try container.encode("redirectURI", forKey: .redirectURI)
        try container.encode("audience", forKey: .audience)
    }
}
