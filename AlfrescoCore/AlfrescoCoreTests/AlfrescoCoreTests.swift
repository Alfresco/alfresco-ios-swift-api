//
//  AlfrescoCoreTests.swift
//  AlfrescoCoreTests
//
//  Created by Silviu Odobescu on 21/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
@testable import AlfrescoCore

class AlfrescoCoreTests: XCTestCase {
    var sut: AlfrescoCore!

    override func setUp() {
        super.setUp()
        sut = AlfrescoCore()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
//    func testRequestBuilderReturnsANonNilRequestBuilderProtocolImplementation() {
//        let requestBuilder = sut.requestBuilder(baseURLString: TestData.baseURLString)
//        
//        XCTAssertNotNil(requestBuilder)
//    }

}
