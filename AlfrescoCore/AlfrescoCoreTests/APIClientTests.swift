//
//  APIClientTests.swift
//  AlfrescoCoreTests
//
//  Created by Emanuel Lupu on 11/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
@testable import AlfrescoCore

class APIClientTests: XCTestCase {
    var sut: APIClient!
    var sessionWithError: MockURLSessionWithError!
    
    override func setUp() {
        super.setUp()
        sessionWithError = MockURLSessionWithError()
    }
    
    override func tearDown() {
        sut = nil
        sessionWithError = nil
        super.tearDown()
    }
    
    func testThatItReportsFailedRequest() {
        let expectation = XCTestExpectation(description: "Session fails with error")
        
        sut = APIClient.init(with: TestData.baseURL, session: sessionWithError)
        _ = sut.send(TestAPIReqest()) { (result) in
            if case .failure (let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
