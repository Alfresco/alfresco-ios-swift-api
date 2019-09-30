//
//  Configuration.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 30/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public struct Configuration: Encodable {
    enum Key: CodingKey {
        case clientID
        case clientSecret
        case baseUrl
        case realm
    }
    
    var clientID: String
    var clientSecret: String?
    var baseUrl: String
    var realm: String
    
    public init(baseUrl: String, clientID: String, realm: String, clientSecret: String = "") {
        self.clientID = clientID
        self.baseUrl = baseUrl
        self.realm = realm
        self.clientSecret = clientSecret
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: Key.self)
        try container.encode("clientID", forKey: .clientID)
        try container.encode("clientSecret", forKey: .clientSecret)
        try container.encode("baseUrl", forKey: .baseUrl)
        try container.encode("realm", forKey: .realm)
    }
}
