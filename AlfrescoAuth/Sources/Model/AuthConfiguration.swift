//
//  Configuration.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 30/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public struct AuthConfiguration: Encodable {
    enum Key: CodingKey {
        case clientID
        case clientSecret
        case baseUrl
        case realm
        case redirectURI
    }
    
    var clientID: String
    var clientSecret: String?
    var baseUrl: String
    var realm: String
    var redirectURI: String?
    
    public init(baseUrl: String, clientID: String, realm: String, clientSecret: String = "", redirectURI: String = "") {
        self.clientID = clientID
        self.baseUrl = baseUrl
        self.realm = realm
        self.clientSecret = clientSecret
        self.redirectURI = redirectURI
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode("clientID", forKey: .clientID)
        try container.encode("clientSecret", forKey: .clientSecret)
        try container.encode("baseUrl", forKey: .baseUrl)
        try container.encode("realm", forKey: .realm)
        try container.encode("redirectURI", forKey: .redirectURI)
    }
}
