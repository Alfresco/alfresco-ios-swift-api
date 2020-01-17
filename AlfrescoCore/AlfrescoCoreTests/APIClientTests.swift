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
    var sessionWithInvalidDataAndResponse: MockURLSessionWithInvalidDataAndResponse!
    var sessionWithSuccessfullResponse: MOCKURLSessionWithSuccessfullResponse!
    var sessionWithInvalidResponse: MOCKURLSessionWithInvalidResponse!
    var sessionWithInvalidStatusCodeResponse: MOCKURLSessionWithInvalidStatusCodeResponse!
    
    override func setUp() {
        super.setUp()
        sessionWithError = MockURLSessionWithError()
        sessionWithInvalidDataAndResponse = MockURLSessionWithInvalidDataAndResponse()
        sessionWithSuccessfullResponse = MOCKURLSessionWithSuccessfullResponse()
        sessionWithInvalidResponse = MOCKURLSessionWithInvalidResponse()
        sessionWithInvalidStatusCodeResponse = MOCKURLSessionWithInvalidStatusCodeResponse()
    }
    
    override func tearDown() {
        sut = nil
        sessionWithError = nil
        sessionWithInvalidDataAndResponse = nil
        sessionWithSuccessfullResponse = nil
        sessionWithInvalidResponse = nil
        sessionWithInvalidStatusCodeResponse = nil
        super.tearDown()
    }
    
    func testThatItReportsFailedRequest() {
        let expectation = XCTestExpectation(description: "Session fails with error")
        
        sut = APIClient.init(with: TestData.baseURL, session: sessionWithError)
        _ = sut.send(TestAPIRequest()) { result in
            if case .failure (let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testThatItReportsFailedRequestForInvalidDataAndResponseParameters() {
        let expectation = XCTestExpectation(description: "Session fails with invalid data and response parameters")
        
        sut = APIClient.init(with: TestData.baseURL, session: sessionWithInvalidDataAndResponse)
        _ = sut.send(TestAPIRequest()) { result in
            if case .failure (let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(errorDataTaskResultNil, error.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testThatItReportsInvalidEndpointCreation() {
        let expectation = XCTestExpectation(description: "Session fails because of invalid endpoint creation")
        
        sut = APIClient.init(with: TestData.invalidBaseURL, session: sessionWithError)
        _ = sut.send(TestAPIRequestWithInvalidPath()) { result in
            if case .failure (let error) = result {
                XCTAssertNotNil(error)
                XCTAssertEqual(errorRequestUnavailable, error.localizedDescription)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testThatItCreatesRequestCorrectly() {
        sut = APIClient.init(with: TestData.baseURL)
        let getDataTask = sut.send(TestAPIRequest()) { result in
        }
        let getRequest = getDataTask?.originalRequest
        
        let postDataTask = sut.send(TestPOSTAPIRequest()) { result in
        }
        let postRequest = postDataTask?.originalRequest
        
        XCTAssertEqual(getRequest?.httpMethod, HttpMethod.get.rawValue)
        XCTAssertEqual(postRequest?.httpMethod, HttpMethod.post.rawValue)
        
        let expectedRequest = String(format: "%@%@?client_id=%@&client_secret=%@", TestData.baseURL, TestData.testAPIRequestPath, TestData.clientID, TestData.clientSecret)
        let alternativeRequest = String(format: "%@%@?client_secret=%@&client_id=%@", TestData.baseURL, TestData.testAPIRequestPath, TestData.clientSecret, TestData.clientID)
        
        var matchingParameters = false
        if getRequest?.url?.absoluteString == expectedRequest ||
            getRequest?.url?.absoluteString == alternativeRequest {
            matchingParameters = true
        }
        
        XCTAssertTrue(matchingParameters)
        XCTAssertEqual(getRequest?.allHTTPHeaderFields, ["Content-Type": ContentType.urlencoded.rawValue])
    }
    
    func testThatItHandlesResponse() {
        let expectation = XCTestExpectation(description: "Request succeeds with credential response")
        
        sut = APIClient.init(with: TestData.baseURL, session: sessionWithSuccessfullResponse)
        _ = sut.send(TestAPIRequest()) { result in
            if case .success (let model) = result {
                XCTAssertEqual(model["name"], "test")
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testThatItHandlesInvalidResponse() {
        let expectation = XCTestExpectation(description: "Request fails because of invalid response")
        
        sut = APIClient.init(with: TestData.baseURL, session: sessionWithInvalidResponse)
        _ = sut.send(TestAPIRequest()) { result in
            if case .failure (let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testThatItHandlesInvalidStatusCodeResponse() {
        let expectation = XCTestExpectation(description: "Request fails because of invalid status code response")
        
        sut = APIClient.init(with: TestData.baseURL, session: sessionWithInvalidStatusCodeResponse)
        _ = sut.send(TestAPIRequest()) { result in
            if case .failure (let error) = result {
                XCTAssertNotNil(error)
                expectation.fulfill()
            }
        }
        
        wait(for: [expectation], timeout: 1.0)
    }
}
