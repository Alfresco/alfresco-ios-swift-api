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

let kWebSAMLURLString = kIssuerPKCE +
    "/protocol/openid-connect/auth?client_id=alfresco&redirect_uri&scope=openid&response_type=code&nonce"
let kIssuerPKCE = "%@/auth/%@"
let kTokenEndPoint = "/auth/realms/%@/protocol/openid-connect/token"
let kLogoutEndPoint = "/protocol/openid-connect/logout"
let moduleName = "AlfrecoAuth"
let kIssuerRealms = "realms/%@"

// Error messages

// PCKE
let errorIssuerNil = "Can't create issuer from base url!"
let errorAuthenticationServiceNotFound = "No authentication service can be found at the provided AlfrescoURL."
let errorViewControllerNil = "ViewController is nil!"
let errorAuthStateNil = "Can't authentificate, authState is nil!"
let errorRetriveFreshToken = "Failed to retrieve a fresh access token."

// WebSSO
let errorAuthCodeNotFound = "Couldn't find AUTHORIZATION CODE!"

// Basic
let errorCredentialNotEmpty = "Credential fields can't be empty!"

// RefreshBasic
let errorRefreshTokenNil = "Cannot request access token because refresh token is missing."

// Module Error Type

public enum ModuleErrorType: Int {
    case errorIssuerNil = 2000
    case errorAuthenticationServiceNotFound = 2001
    case errorViewControllerNil = 2002
    case errorAuthStateNil = 2003
    case errorRetriveFreshToken = 2004
    case errorAuthCodeNotFound = 2005
    case errorCredentialsNotEmpty = 2006
    case errorRefreshTokenNil = 2008

    public var code: Int {
        return rawValue
    }
}
