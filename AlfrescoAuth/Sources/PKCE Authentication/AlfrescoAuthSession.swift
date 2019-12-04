//
//  AlfrescoAuthSession.swift
//  AlfrescoAuth
//
//  Created by Emanuel Lupu on 02/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AppAuth

public class AlfrescoAuthSession: NSObject, NSSecureCoding {
    
    public static var supportsSecureCoding: Bool = true
    
    var authorizationFlow: OIDExternalUserAgentSession?
    var authState: OIDAuthState?
    
    public func encode(with coder: NSCoder) {
        coder.encode(authState, forKey: "authState")
    }
    
    public required init?(coder: NSCoder) {
        guard
            let authState = coder.decodeObject(forKey: "authState") as? OIDAuthState
        else {
            return nil
        }
        
        self.authState = authState
    }
    
    override public init() {
        super.init()
    }
    
    public func resumeExternalUserAgentFlow(with url: URL) -> Bool {
        if let authorizationFlow = self.authorizationFlow, authorizationFlow.resumeExternalUserAgentFlow(with: url) {
            self.authorizationFlow = nil
            return true
        }
        return false
    }
}
