//
//  AuthConfigurationTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 14/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
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
