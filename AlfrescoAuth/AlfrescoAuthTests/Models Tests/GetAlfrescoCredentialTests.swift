//
//  GetAlfrescoCredentialTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 14/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
import AppAuth
@testable import AlfrescoAuth

class GetAlfrescoCredentialTests: XCTestCase {
    var sut: GetAlfrescoCredential!
    
    override func setUp() {
        super.setUp()
        sut = GetAlfrescoCredential()
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
        sut = GetAlfrescoCredential(username: TestData.username1, password: TestData.password1, configuration: TestData.configuration)
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
