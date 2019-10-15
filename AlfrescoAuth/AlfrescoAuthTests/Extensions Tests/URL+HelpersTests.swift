//
//  URL+HelpersTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 14/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
@testable import AlfrescoAuth

class URLHelpersTest: XCTestCase {
    var sut: URL!
    
    override func setUp() {
        super.setUp()
        sut = URL(string: TestData.baseUrlGood)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testFindAuthorizationCode() {
        sut = URL(string: TestData.urlStringToLoadGood)
        let code = sut.findAuthorizationCode()
        XCTAssertEqual(code, TestData.codeGood)
    }
}
