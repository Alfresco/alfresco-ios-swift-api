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
@testable import AlfrescoCore

struct TestData {
    static let baseURL = "http://domain.extension"
    static let invalidBaseURL = " "
    static let testAPIRequestPath = "/path"
    static let invalidAPIRequestPath = " "
    static let clientID = "id"
    static let clientSecret = "secret"
    static var response = ["name": "test"]
    static var invalidResponse = "response"
    static let errorDomain = "domain"
    static let errorCode = 1000
    static let errorMessage = "message"
    static let errorObj = APIError(domain: "test", code: 0, message: "error message")
}
