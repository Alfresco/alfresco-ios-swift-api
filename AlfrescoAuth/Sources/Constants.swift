//
//  Constants.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

let kWebSAMLURLString = "%@/auth/realms/%@/protocol/openid-connect/auth?client_id=alfresco&redirect_uri&scope=openid&response_type=code&nonce"
let kIssuerPKCE = "%@/auth/realms/%@"
let kTokenEndPoint = "/auth/realms/%@/protocol/openid-connect/token"
let kLogoutEndPoint = "/protocol/openid-connect/logout"
let moduleName = "AlfrecoAuth"

// Error messages
//PCKE
let errorIssuerNil = "Can't create issuer from base url!"
let errorAuthenticationServiceNotFound = "No authentication service can be found at the provided AlfrescoURL."
let errorViewControllerNil = "ViewController is nil!"
let errorAuthStateNil = "Can't authentificate, authState is nil!"
let errorRetriveFreshToken = "Failed to retrieve a fresh access token."
//WebSSO
let errorAuthCodeNotFound = "Couldn't find AUTHORIZATION CODE!"
//Basic
let errorUsernameNotEmpty = "Username field can't be empty!"
let errorPasswordNotEmpty = "Password field can't be empty!"
//RefreshBasic
let errorRefreshTokenNil = "Cannot request access token because refresh token is missing."

// Module Error Type

public enum ModuleErrorType: Int {
    case errorIssuerNil = 2000
    case errorAuthenticationServiceNotFound = 2001
    case errorViewControllerNil = 2002
    case errorAuthStateNil = 2003
    case errorRetriveFreshToken = 2004
    
    case errorAuthCodeNotFound = 2005
    
    case errorUsernameNotEmpty = 2006
    case errorPasswordNotEmpty = 2007
    
    case errorRefreshTokenNil = 2008
    
    public var code: Int {
        return rawValue
    }
}
