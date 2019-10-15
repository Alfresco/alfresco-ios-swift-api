//
//  AlfrescoCredentialTests.swift
//  AlfrescoAuthTests
//
//  Created by Silviu Odobescu on 05/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
import AppAuth
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
    
    func testInitWithOIDTokenResponse() {
        sut = AlfrescoCredential(with: nil)
        XCTAssertEqual(sut.accessToken, nil)
        XCTAssertEqual(sut.accessTokenExpiresIn, 0)
        XCTAssertEqual(sut.refreshToken, nil)
        XCTAssertEqual(sut.refreshTokenExpiresIn, 0)
        XCTAssertEqual(sut.tokenType, nil)
        XCTAssertEqual(sut.sessionState, "")
    }
    
    func testInitWithDecoder() {
        sut = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: TestData.dictionaryAlfrescoCredentialGood, options: .prettyPrinted)
            let csut = try JSONDecoder().decode(AlfrescoCredential.self, from: jsonData)
            
            XCTAssertEqual(sut.accessToken, csut.accessToken)
            XCTAssertEqual(sut.accessTokenExpiresIn, csut.accessTokenExpiresIn)
            XCTAssertEqual(sut.refreshToken, csut.refreshToken)
            XCTAssertEqual(sut.refreshTokenExpiresIn, csut.refreshTokenExpiresIn)
            XCTAssertEqual(sut.tokenType, csut.tokenType)
            XCTAssertEqual(sut.sessionState, csut.sessionState)
        } catch {
            print("Couldn't decode.")
        }
    }
}


