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
