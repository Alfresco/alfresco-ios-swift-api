//
//  AlfrescoCredentialTests.swift
//  AlfrescoAuthTests
//
//  Created by Silviu Odobescu on 05/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
@testable import AlfrescoAuth

class AuthCredentialTests: XCTestCase {
    var sut: AlfrescoCredential!
    
    override func setUp() {
        super.setUp()
        sut = AlfrescoCredential()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInitWithDictionarySetsProperties() {
        sut = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        
        XCTAssertEqual(sut.accessToken, TestData.accessTokenGood)
        XCTAssertEqual(sut.accessTokenExpiresIn, TestData.accessTokenExpiresInGood)
        XCTAssertEqual(sut.refreshToken, TestData.refreshTokenGood)
        XCTAssertEqual(sut.refreshTokenExpiresIn, TestData.refreshTokenExpiresInGood)
        XCTAssertEqual(sut.tokenType, TestData.tokenTypeGood)
        XCTAssertEqual(sut.sessionState, TestData.sessionStateGood)
    }
    
    func testInitWithDictionaryExtraSetsProperties() {
        sut = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialExtra)
        
        XCTAssertEqual(sut.accessToken, TestData.accessTokenGood)
        XCTAssertEqual(sut.accessTokenExpiresIn, TestData.accessTokenExpiresInGood)
        XCTAssertEqual(sut.refreshToken, TestData.refreshTokenGood)
        XCTAssertEqual(sut.refreshTokenExpiresIn, TestData.refreshTokenExpiresInGood)
        XCTAssertEqual(sut.tokenType, TestData.tokenTypeGood)
        XCTAssertEqual(sut.sessionState, TestData.sessionStateGood)
    }
}
