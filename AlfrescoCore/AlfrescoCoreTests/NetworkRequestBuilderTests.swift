//
//  NetworkRequestBuilderTests.swift
//  AlfrescoCoreTests
//
//  Created by Silviu Odobescu on 27/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
@testable import AlfrescoCore

class NetworkRequestBuilderTests: XCTestCase {
    var sut : NetworkRequestBuilder!
    
    override func setUp() {
        super.setUp()
        let url = URL(string: TestData.baseURLString)
        sut = NetworkRequestBuilder(baseURL: url)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testRequestPostMethodReturnsPostMethod() {
        let urlRequest = sut.request(method: .post, path: TestData.path)
        
        XCTAssertEqual(HttpMethod.post.rawValue, urlRequest?.httpMethod)
    }
    
    func testRequestMethodSetsHeaderFields() {
        let urlRequest = sut.request(method: .post, path: TestData.path, headerFields: [TestData.headerFieldsContentType: TestData.headerFieldsContentTypeValue])
        XCTAssertEqual(urlRequest?.allHTTPHeaderFields?[TestData.headerFieldsContentType], TestData.headerFieldsContentTypeValue)
    }

    func testRequestPostMethodSetsParamsInHttpBody() {
        let urlRequest = sut.request(method: .post, path: TestData.path, headerFields: nil, parameters: TestData.params)
        
        XCTAssertEqual(urlRequest?.httpBody, TestData.paramsPercentEscaped.data(using: .utf8))
    }
    
    func testRequestGetMethodSetsParamsInURL() {
        let urlRequest = sut.request(method: .get, path: TestData.path, headerFields: nil, parameters: TestData.params)
        
        XCTAssertEqual(urlRequest?.url?.absoluteString, TestData.getURLWithParams)
    }
}
