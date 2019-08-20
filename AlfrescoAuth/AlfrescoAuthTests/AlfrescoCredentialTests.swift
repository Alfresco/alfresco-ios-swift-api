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
    
    func testInitWithUrlStringSetsProperties() {
        sut = AlfrescoCredential(with: URL(string:TestData.urlString)!)
        
        XCTAssertEqual(sut.sessionState, TestData.sessionStateString)
        XCTAssertEqual(sut.idToken, TestData.idTokenString)
        XCTAssertEqual(sut.tokenType, TestData.tokenType)
        XCTAssertEqual(sut.expiresIn, TestData.expiresIn)
    }
    
    func testInitWithUrlStringWithExtraParamSetsProperties() {
        sut = AlfrescoCredential(with: URL(string:TestData.urlStringWithExtraParam)!)
        
        XCTAssertEqual(sut.sessionState, TestData.sessionStateString)
        XCTAssertEqual(sut.idToken, TestData.idTokenString)
        XCTAssertEqual(sut.tokenType, TestData.tokenType)
        XCTAssertEqual(sut.expiresIn, TestData.expiresIn)
    }
    
    func testInitWithUrlStringWithExpiresInString() {
        sut = AlfrescoCredential(with: URL(string:TestData.urlStringWithExpiresInString)!)
        
        XCTAssertEqual(sut.sessionState, TestData.sessionStateString)
        XCTAssertEqual(sut.idToken, TestData.idTokenString)
        XCTAssertEqual(sut.tokenType, TestData.tokenType)
        XCTAssertEqual(sut.expiresIn, 0)
    }
}
