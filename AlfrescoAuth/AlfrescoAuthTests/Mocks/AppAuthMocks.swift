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
