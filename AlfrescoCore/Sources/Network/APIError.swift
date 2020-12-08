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

public struct APIError: Error {
    public let domain: String
    public var userInfo: [String: Any]
    public let responseCode: Int

    /**
    Designated initializer for request errors.
    - Remark: By convention, the domain of the error will be populated with  the module name.
    - Parameter domain: Error domain name.
    - Parameter code: Request status code
    - Parameter message: Error message
    - Parameter userInfo: Custom object to be passed along the error.
     If a message value is provided, the *userInfo* property will be overridden
    - Parameter error: Optional underlaying error object
    */
    public init(domain: String,
                code: Int = 0,
                message: String = "",
                userInfo: [String: Any] = ["": ""],
                error: Error? = nil ) {
        self.domain = domain
        self.responseCode = code
        self.userInfo = userInfo
        if message != "" {
            self.userInfo = [NSLocalizedDescriptionKey: message]
        }
        if let error = error {
            self.userInfo = [NSLocalizedDescriptionKey: error.localizedDescription]
            if message != "" {
                self.userInfo = [NSLocalizedFailureErrorKey: message]
            }
        }
    }

    public var localizedDescription: String {
        if let message = self.userInfo[NSLocalizedDescriptionKey] {
            return message as? String ?? ""
        } else {
            return userInfo["error_description"] as? String ?? ""
        }
    }
}
