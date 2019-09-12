//
//  GetToken.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 10/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AlfrescoCore

enum GrantType: String {
    case password = "password"
    case refresh = "refresh_token"
    case code = "authorization_code"
}

struct GetToken: APIRequest {
    typealias Response = AlfrescoCredential
    
    var path: String {
        return kTokenEndpoint
    }
    
    var method: HttpMethod {
        return .post
    }
    
    var headers: [String : ContentType] {
        return ["Content-Type": .urlencoded]
    }
    
    var parameters: [String : String] {
        switch grantType {
        case .code:
            return ["grant_type": grantType?.rawValue ?? "",
                    "client_id": kClientID,
                    "client_secret": kClientSecret,
                    "redirect_uri": "",
                    "code": code ?? ""]
        case .refresh: break
        case .password:
            return ["grant_type": "password",
                    "client_id": kClientID,
                    "client_secret": kClientSecret,
                    "username": username ?? "",
                    "password": password ?? ""]
        case .none: break
        }
        
        return ["": ""]
    }
    
    var code: String?
    var username: String?
    var password: String?
    var grantType: GrantType?
    var clientID: String = kClientID
    var clientSecret = kClientSecret
    var redirectUri = ""
    
    init(code: String) {
        self.code = code
        self.grantType = .code
    }
    
    init(username: String, password: String) {
        self.username = username
        self.password = password
        self.grantType = .password
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
