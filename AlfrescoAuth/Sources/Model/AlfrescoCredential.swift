//
//  AlfrescoCredential.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AppAuth

public struct AlfrescoCredential: Decodable {
    var tokenType: String!
    var accessToken: String!
    var accessTokenExpiresIn: Int!
    var refreshToken: String!
    var refreshTokenExpiresIn: Int!
    var sessionState: String!

    enum CodingKeys: String, CodingKey {
        case tokenType = "token_type"
        case accessToken = "access_token"
        case accessTokenExpiresIn = "expires_in"
        case refreshToken = "refresh_token"
        case refreshTokenExpiresIn = "refresh_expires_in"
        case sessionState = "session_state"
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
    }
    
    
    public init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        tokenType = try values.decode(String.self, forKey: .tokenType)
        accessToken = try values.decode(String.self, forKey: .accessToken)
        accessTokenExpiresIn = try values.decode(Int.self, forKey: .accessTokenExpiresIn)
        refreshToken = try values.decode(String.self, forKey: .refreshToken)
        refreshTokenExpiresIn = try values.decode(Int.self, forKey: .refreshTokenExpiresIn)
        sessionState = try values.decode(String.self, forKey: .sessionState)
    }
}
