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
import AlfrescoCore

enum GrantType: String {
    case password = "password"
    case refresh = "refresh_token"
    case code = "authorization_code"
}

struct GetAlfrescoCredential: APIRequest {
    typealias Response = AlfrescoCredential
    
    var path: String {
        return String(format: kTokenEndPoint, configuration.realm)
    }
    
    var method: HttpMethod {
        return .post
    }
    
    var headers: [String : String] {
        return ["Content-Type": ContentType.urlencoded.rawValue]
    }
    
    var parameters: [String : String] {
        switch grantType {
        case .code:
            return ["grant_type": grantType?.rawValue ?? "",
                    "client_id": configuration.clientID,
                    "client_secret": configuration.clientSecret ?? "",
                    "redirect_uri": "",
                    "code": code ?? ""]
        case .refresh:
            return ["grant_type": grantType?.rawValue ?? "",
                    "client_id": configuration.clientID,
                    "client_secret": configuration.clientSecret ?? "",
                    "refresh_token": refreshToken ?? ""]
        case .password:
            return ["grant_type": grantType?.rawValue ?? "",
                    "client_id": configuration.clientID,
                    "client_secret": configuration.clientSecret ?? "",
                    "username": username ?? "",
                    "password": password ?? ""]
        case .none: break
        }
        
        return ["": ""]
    }
    
    var code: String?
    var username: String?
    var password: String?
    var refreshToken: String?
    var grantType: GrantType?
    var configuration: AuthConfiguration
    var redirectUri = ""
    
    init(code: String, configuration: AuthConfiguration) {
        self.code = code
        self.grantType = .code
        self.configuration = configuration
    }
    
    init(username: String, password: String, configuration: AuthConfiguration) {
        self.username = username
        self.password = password
        self.grantType = .password
        self.configuration = configuration
    }
    
    init(refreshToken: String, configuration: AuthConfiguration) {
        self.refreshToken = refreshToken
        self.grantType = .refresh
        self.configuration = configuration
    }
}

extension GrantType: Codable {
    enum Key: CodingKey {
        case rawValue
    }
    enum CodingError: Error {
        case unknownValue
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: Key.self)
        let rawValue = try container.decode(String.self, forKey: .rawValue)
        switch rawValue {
        case "password":
            self = .password
        case "refresh_token":
            self = .refresh
        case "authorization_code":
            self = .code
        default:
            throw CodingError.unknownValue
        }
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        switch self {
        case .password:
            try container.encode("password", forKey: .rawValue)
        case .refresh:
            try container.encode("refresh_token", forKey: .rawValue)
        case .code:
            try container.encode("authorization_code", forKey: .rawValue)
        }
    }
}
