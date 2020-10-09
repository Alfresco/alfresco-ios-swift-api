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

class AuthConfigurationTests: XCTestCase {
    var sut: AuthConfiguration!
    
    override func setUp() {
        super.setUp()
        sut = AuthConfiguration(baseUrl: TestData.baseUrlGood, clientID: TestData.clientIDGood, realm: TestData.realmGood)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInitWithAllProperties() {
        sut = AuthConfiguration(baseUrl: TestData.baseUrlGood, clientID: TestData.clientIDGood, realm: TestData.realmGood, clientSecret: TestData.clientSecretGood, redirectURI: TestData.redirectUriGood)
        XCTAssertEqual(sut.baseUrl, TestData.baseUrlGood)
        XCTAssertEqual(sut.clientID, TestData.clientIDGood)
        XCTAssertEqual(sut.realm, TestData.realmGood)
        XCTAssertEqual(sut.clientSecret, TestData.clientSecretGood)
        XCTAssertEqual(sut.redirectURI, TestData.redirectUriGood)
    }
    
    func testInitWithNonOptionalProperties() {
        sut = AuthConfiguration(baseUrl: TestData.baseUrlGood, clientID: TestData.clientIDGood, realm: TestData.realmGood)
        XCTAssertEqual(sut.baseUrl, TestData.baseUrlGood)
        XCTAssertEqual(sut.clientID, TestData.clientIDGood)
        XCTAssertEqual(sut.realm, TestData.realmGood)
        XCTAssertNil(sut.clientSecret)
        XCTAssertEqual(sut.redirectURI, "")
    }
}
