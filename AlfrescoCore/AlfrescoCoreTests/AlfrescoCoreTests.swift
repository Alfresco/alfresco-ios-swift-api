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
    var sut: TestAPIReqest!
    
    override func setUp() {
        super.setUp()
        sut = TestAPIReqest()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testAPIRequestProtocolConformanceForAdopter () {
        XCTAssertEqual("/path", sut.path)
        XCTAssertEqual(HttpMethod.get, sut.method)
        XCTAssertEqual(["Content-Type" : ContentType.urlencoded], sut.headers)
        XCTAssertEqual(["client_id": "id",
                        "client_secret": "secret"], sut.parameters)
    }
    
}
