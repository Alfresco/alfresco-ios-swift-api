//
//  String+HelpersTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 14/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
@testable import AlfrescoAuth

class StringHelpersTests: XCTestCase {
    var sut: String!
    
    override func setUp() {
        super.setUp()
        sut = String()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testReplaceHashTagWithQuestionMark() {
        sut = TestData.urlStringWithHashtag
        let code = sut.replaceHashTagWithQuestionMark()
        XCTAssertFalse(code.contains("#"))
    }
}
