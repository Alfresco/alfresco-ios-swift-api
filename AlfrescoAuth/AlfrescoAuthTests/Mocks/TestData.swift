//
//  TestData.swift
//  AlfrescoAuthTests
//
//  Created by Silviu Odobescu on 05/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AlfrescoAuth
import AppAuth
@testable import AlfrescoAuth

struct TestData {
    static let urlStringToLoadGood = "http://alfresco-identity-service.mobile.dev.alfresco.me/auth/?session_state=21d3459e&code=f744e33&scope=profile"
    static let urlStringWithoutCode = "http://alfresco-identity-service.mobile.dev.alfresco.me/auth/?session_state=21d3459e&scope=profile"
    static let urlStringWithHashtag = "http://alfresco-identity-service.mobile.dev.alfresco.me/auth/#?session_state=21d3459e"
    
    static let username1 = "admin"
    static let password1 = "admin"
    static let password2 = "adm ins"
    
    static let errorMessage1 = "This is an error!"
    
    static let codeGood = "f744e33"
    
    static let accessTokenGood = "eyJhbGciOiJSUzI1NiIsInR5cCIgOi"
    static let accessTokenExpiresInGood = 300
    static let refreshTokenGood = "eyJhbGciOiJIUzI1NiIsInR5cCIgOis"
    static let refreshTokenExpiresInGood = 1800
    static let tokenTypeGood = "bearer"
    static let sessionStateGood = "21d3459e"
    static let dictionaryAlfrescoCredentialGood = [
        "access_token": accessTokenGood,
        "expires_in": accessTokenExpiresInGood,
        "refresh_expires_in": refreshTokenExpiresInGood,
        "refresh_token": refreshTokenGood,
        "token_type": tokenTypeGood,
        "session_state": sessionStateGood
        ] as [String : Any]
    static let dictionaryAlfrescoCredentialExtra = [
        "access_token": accessTokenGood,
        "expires_in": accessTokenExpiresInGood,
        "refresh_expires_in": refreshTokenExpiresInGood,
        "refresh_token": refreshTokenGood,
        "token_type": tokenTypeGood,
        "session_state": sessionStateGood,
        "scope": "profile email"
        ] as [String : Any]
    
    static let baseUrlGood = "http://alfresco-identity-service.mobile.dev.alfresco.me"
    static let clientIDGood = "alfresco"
    static let realmGood = "alfresco"
    static let clientSecretGood = "4bd63685-9e36-492d-8002-df2c6652ffb1"
    static let redirectUriGood = "http://fakeurl.ro"
    static let configuration = AuthConfiguration(baseUrl: baseUrlGood,
                                                 clientID: clientIDGood,
                                                 realm: realmGood,
                                                 clientSecret: clientSecretGood,
                                                 redirectURI: redirectUriGood)
}
