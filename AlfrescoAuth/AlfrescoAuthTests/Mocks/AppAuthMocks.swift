//
//  AppAuthMocks.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 15/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AppAuth

class OIDTokenResponseStub: OIDTokenResponse {
    override var tokenType: String? {
        return TestData.tokenTypeGood
    }
    override var accessToken: String? {
        return TestData.accessTokenGood
    }
    override var accessTokenExpirationDate: Date? {
        return Date(timeIntervalSince1970: TimeInterval(TestData.accessTokenExpiresInGood))
    }
    override var refreshToken: String? {
        return TestData.refreshTokenGood
    }
}

class OIDExternalUserAgentSessionStub: NSObject, OIDExternalUserAgentSession {
    var successResponse: Bool = true
    
    func resumeExternalUserAgentFlow(with URL: URL) -> Bool {
        return successResponse
    }
    
    func cancel() { }
    
    func cancel(completion: (() -> Void)? = nil) { }
    
    func failExternalUserAgentFlowWithError(_ error: Error) { }
}

class OIDAuthStateStub: OIDAuthState {
    var successResponse: Bool = true
    
    override func performAction(freshTokens action: @escaping OIDAuthStateAction) {
        if successResponse {
            action(TestData.accessTokenGood, "", nil)
        } else {
            action(nil, "", NSError())
        }
    }
}
