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
import AppAuth
public struct AlfrescoCredential: Codable {
    public var tokenType: String?
    public var accessToken: String?
    public var accessTokenExpiresIn: Int?
    public var refreshToken: String?
    public var refreshTokenExpiresIn: Int?
    public var sessionState: String?
    public var idToken: String?
    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case accessTokenExpiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_expires_in"
        case sessionState = "session_state"
        case idToken = "id_token"
    }
    init() { }
    init(with dictionary: [String: Any]) {
        for (key, value) in dictionary {
            switch key {
            case "session_state":
                sessionState = value as? String
            case "access_token":
                accessToken = value as? String
            case "token_type":
                tokenType = value as? String
            case "expires_in":
                accessTokenExpiresIn = value as? Int
            case "refresh_token":
                refreshToken = value as? String
            case "refresh_expires_in":
                refreshTokenExpiresIn = value as? Int
            case "id_token":
                idToken = value as? String
            default: break
            }
        }
    }
    init(with response: OIDTokenResponse?) {
        self.tokenType = response?.tokenType
        self.accessToken = response?.accessToken
        self.accessTokenExpiresIn = Int(response?.accessTokenExpirationDate?.timeIntervalSince1970 ?? 0)
        self.refreshToken = response?.refreshToken
        self.refreshTokenExpiresIn = 0
        self.sessionState = ""
        self.idToken = response?.idToken
    }
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tokenType = try values.decode(String.self, forKey: .tokenType)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        accessTokenExpiresIn = try values.decode(Int.self, forKey: .accessTokenExpiresIn)
        refreshToken = try values.decode(String.self, forKey: .refreshToken)
        refreshTokenExpiresIn = try values.decode(Int.self, forKey: .refreshTokenExpiresIn)
        sessionState = try values.decode(String.self, forKey: .sessionState)
        idToken = try values.decode(String.self, forKey: .idToken)
    }
}
