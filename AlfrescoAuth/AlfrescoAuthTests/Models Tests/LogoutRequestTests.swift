//
//  LogoutRequestTests.swift
//  AlfrescoAuthTests
//
//  Created by Emanuel Lupu on 09/12/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
@testable import AlfrescoAuth

class LogoutRequestTests: XCTestCase {
    var sut: LogoutRequest!
    
    override func setUp() {
        super.setUp()
        sut = LogoutRequest(serviceDocumentInstanceURL: "baseURL")
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testThatItCreatesPath() {
        XCTAssertEqual("baseURL/protocol/openid-connect/logout", sut.path)
    }
    
    func testThatItReturnsGetVerb() {
        XCTAssertEqual(.get, sut.method)
    }
    
    func testThatItHasNoHeadersSet() {
        XCTAssertEqual([:], sut.headers)
    }
    
    func testThatItHasNoParameters() {
        XCTAssertEqual([:], sut.parameters)
    }
}
