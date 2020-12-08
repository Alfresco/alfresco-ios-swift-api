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
import XCTest
import AppAuth
@testable import AlfrescoAuth

class GetAlfrescoCredentialTests: XCTestCase {
    var sut: GetAlfrescoCredential!

    override func setUp() {
        super.setUp()
        sut = GetAlfrescoCredential(code: TestData.codeGood, configuration: TestData.configuration)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }

    func testInitForGrantTypeCode() {
        sut = GetAlfrescoCredential(code: TestData.codeGood, configuration: TestData.configuration)
        XCTAssertEqual(sut.code, TestData.codeGood)
        XCTAssertEqual(sut.configuration, TestData.configuration)
        XCTAssertEqual(sut.grantType, GrantType.code)
    }

    func testInitForGrantTypePassword() {
        sut = GetAlfrescoCredential(username: TestData.username1,
                                    password: TestData.password1,
                                    configuration: TestData.configuration)
        XCTAssertEqual(sut.username, TestData.username1)
        XCTAssertEqual(sut.password, TestData.password1)
        XCTAssertEqual(sut.configuration, TestData.configuration)
        XCTAssertEqual(sut.grantType, GrantType.password)
    }

    func testInitForGrantTypeRefresh() {
        sut = GetAlfrescoCredential(refreshToken: TestData.refreshTokenGood, configuration: TestData.configuration)
        XCTAssertEqual(sut.refreshToken, TestData.refreshTokenGood)
        XCTAssertEqual(sut.configuration, TestData.configuration)
        XCTAssertEqual(sut.grantType, GrantType.refresh)
    }
}
