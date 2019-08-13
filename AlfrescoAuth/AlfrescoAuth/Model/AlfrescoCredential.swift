//
//  AlfrescoCredential.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public struct AlfrescoCredential {
    var sessionState: String?
    var idToken: String?
    var accessToken: String?
    var tokenType: String?
    var expiresIn: Int?
    
    init() {
    }
    
    init(from url:URL) {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryItems = urlComponents?.queryItems {
            for item in queryItems {
                switch item.name {
                case "session_state":
                    sessionState = item.value!
                case "id_token":
                    idToken = item.value!
                case "access_token":
                    accessToken = item.value!
                case "token_type":
                    tokenType = item.value!
                case "expires_in":
                    expiresIn = Int(item.value!) ?? 0
                default: break
                }
            }
        }
    }
}
