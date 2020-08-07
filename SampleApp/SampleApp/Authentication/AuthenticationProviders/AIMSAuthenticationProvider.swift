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
import AlfrescoAuth
import JWTDecode

class AIMSAuthenticationProvider: AuthenticationProviderProtocol {
    let credential: AlfrescoCredential

    init(with credential: AlfrescoCredential) {
        self.credential = credential
    }

    func identifier() -> String {
        guard let token = credential.accessToken else { return "" }

        do {
            let jwt = try decode(jwt: token)
            let claim = jwt.claim(name: "preferred_username")
            if let preferredusername = claim.string {
                return preferredusername
            }
        } catch {}

        return ""
    }

    func authorizationHeader() -> [String: String] {
        return ["Authorization": authorizationHeaderValue()]
    }

    func authorizationHeaderValue() -> String {
        guard let accessToken = credential.accessToken else { return "" }
        return String("Bearer \(accessToken)")
    }

    func areCredentialsValid() -> Bool {
        guard let accesTokenExpiresIn = credential.accessTokenExpiresIn else { return false }
        let tokenExpireDate = Date(timeIntervalSince1970: TimeInterval(accesTokenExpiresIn))

        if Date().compare(tokenExpireDate) == .orderedDescending {
            return false
        }

        return true
    }
}
