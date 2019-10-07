//
//  AlfrescoAuthSession.swift
//  AlfrescoAuth
//
//  Created by Emanuel Lupu on 02/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AppAuth

public struct AlfrescoAuthSession {
    var authorizationFlow: OIDExternalUserAgentSession?
    var authState: OIDAuthState?
    
    public mutating func resumeExternalUserAgentFlow(with url: URL) -> Bool {
        if let authorizationFlow = self.authorizationFlow, authorizationFlow.resumeExternalUserAgentFlow(with: url) {
            self.authorizationFlow = nil
            return true
        }
        return false
    }
}
