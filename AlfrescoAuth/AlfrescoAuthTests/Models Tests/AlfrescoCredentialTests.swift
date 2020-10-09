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


