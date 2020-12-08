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

struct TestAPIRequest: APIRequest {
    typealias Response = [String: String]

    var path: String {
        return TestData.testAPIRequestPath
    }

    var method: HttpMethod {
        return .get
    }

    var headers: [String: String] {
        return ["Content-Type": ContentType.urlencoded.rawValue]
    }

    var parameters: [String: String] {
        return ["client_id": TestData.clientID,
                "client_secret": TestData.clientSecret]
    }
}

struct TestPOSTAPIRequest: APIRequest {
    typealias Response = String

    var path: String {
        return TestData.testAPIRequestPath
    }

    var method: HttpMethod {
        return .post

    }
    var headers: [String: String] {
        return ["Content-Type": ContentType.urlencoded.rawValue]
    }

    var parameters: [String: String] {
        return ["client_id": TestData.clientID,
                "client_secret": TestData.clientSecret]
    }
}

struct TestAPIRequestWithInvalidPath: APIRequest {
    typealias Response = String

    var path: String {
        return TestData.invalidAPIRequestPath
    }

    var method: HttpMethod {
        return .get
    }

    var headers: [String: String] {
        return ["Content-Type": ContentType.urlencoded.rawValue]
    }

    var parameters: [String: String] {
        return ["client_id": TestData.clientID,
                "client_secret": TestData.clientSecret]
    }
}
