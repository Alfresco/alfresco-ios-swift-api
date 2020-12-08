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

import XCTest
@testable import AlfrescoCore

class APIErrorTests: XCTestCase {
    var sut: APIError!

    override func setUp() {
        super.setUp()

        sut = APIError(domain: TestData.errorDomain,
                       code: TestData.errorCode,
                       message: TestData.errorMessage,
                       userInfo: TestData.response,
                       error: TestData.errorObj)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testThatErrorObjectIsGeneratedCorrectly() {
        XCTAssertEqual(TestData.errorDomain, sut.domain)
        XCTAssertEqual(TestData.errorCode, sut.responseCode)
        XCTAssertEqual(TestData.errorMessage, sut.userInfo[NSLocalizedFailureErrorKey] as? String)
        XCTAssertEqual("", sut.localizedDescription)
    }
}
