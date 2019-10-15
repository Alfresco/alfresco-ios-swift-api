//
//  AlfrescoErrorTests.swift
//  AlfrescoCoreTests
//
//  Created by Emanuel Lupu on 15/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
@testable import AlfrescoCore

class APIErrorTests: XCTestCase {
    var sut: APIError!
    
    override func setUp() {
        super.setUp()
        
        sut = APIError(domain: TestData.errorDomain,
                       code: TestData.errorCode,
                       message: TestData.errorMessage,
                       userInfo: TestData.response,
                       error: TestData.errorObj)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    
    func testThatErrorObjectIsGeneratedCorrectly() {
        XCTAssertEqual(TestData.errorDomain, sut.domain)
        XCTAssertEqual(TestData.errorCode, sut.responseCode)
        XCTAssertEqual(TestData.errorMessage, sut.userInfo[NSLocalizedFailureErrorKey] as! String)
        XCTAssertEqual("", sut.localizedDescription)
    }
}
