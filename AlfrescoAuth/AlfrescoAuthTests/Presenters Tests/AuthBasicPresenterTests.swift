//
//  AuthBasicPresenter.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 16/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
import AlfrescoCore
@testable import AlfrescoAuth

class AuthBasicPresenterTests: XCTestCase {
    var sut: AuthBasicPresenter!
    var expectationForDidRevicedCall = XCTestExpectation(description: "Wait for delegate.")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Success in DidRecivedCall")
    var expectationForFailureInDidRecivedCall = XCTestExpectation(description: "Failure in DidRecivedCall")
    
    override func setUp() {
        super.setUp()
        sut = AuthBasicPresenter(configuration: TestData.configuration)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInitWithConfiguration() {
        sut = AuthBasicPresenter(configuration: TestData.configuration)
        XCTAssertEqual(sut.configuration, TestData.configuration)
    }
    
    func testExecuteWithSuccess() {
        let delegateStub = AlfrescoAuthDelegateStub()
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        
        apiClientSub.successResponse = true
        delegateStub.expectationForDidRevicedCall = expectationForDidRevicedCall
        delegateStub.expectationForSuccessInDidRecivedCall = expectationForSuccessInDidRecivedCall
        
        sut.authDelegate = delegateStub
        sut.apiClient = apiClientSub
        sut.execute(username: TestData.username1, password: TestData.password1)
        
        wait(for: [expectationForDidRevicedCall, expectationForSuccessInDidRecivedCall], timeout: 10.0)
    }
    
    func testExecuteWithFailure() {
        let delegateStub = AlfrescoAuthDelegateStub()
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        
        apiClientSub.successResponse = false
        delegateStub.expectationForDidRevicedCall = expectationForDidRevicedCall
        delegateStub.expectationForFailureInDidRecivedCall = expectationForFailureInDidRecivedCall
        
        sut.authDelegate = delegateStub
        sut.apiClient = apiClientSub
        sut.execute(username: TestData.username1, password: TestData.password2)
        
        wait(for: [expectationForDidRevicedCall, expectationForFailureInDidRecivedCall], timeout: 10.0)
    }
    
    func testRequestTokenWithSuccess() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientSub.successResponse = true
        sut.apiClient = apiClientSub
        sut.requestToken(with: TestData.username1, and: TestData.password1, completion: { (result) in
            var success = false
            switch result {
            case .success(_):
                success = true
            case .failure(_):
                success = false
            }
            XCTAssertTrue(success)
        })
    }
    
    func testRequestTokenWithFailure() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientSub.successResponse = false
        sut.apiClient = apiClientSub
        sut.requestToken(with: TestData.username1, and: TestData.password2, completion: { (result) in
            var success = false
            switch result {
            case .success(_):
                success = true
            case .failure(_):
                success = false
            }
            XCTAssertFalse(success)
        })
    }
    
    func testSutVerifyCallsWithInputTypeUsernameAndStringNotNil() {
        let string = sut.verify(string: TestData.username1, type: .username)
        XCTAssertNotNil(string)
    }
    
    func testSutVerifyCallsWithInputTypeUsernameAndNilStringNotNil() {
        let string = sut.verify(string: nil, type: .username)
        XCTAssertNil(string)
    }
    
    func testSutVerifyCallsWithInputTypeUsernameAndEmptyStringNotNil() {
        let string = sut.verify(string: "", type: .username)
        XCTAssertNil(string)
    }
    
    func testSutVerifyCallsWithInputTypePasswordAndStringNotNil() {
        let string = sut.verify(string: TestData.password1, type: .password)
        XCTAssertNotNil(string)
    }
    
    func testSutVerifyCallsWithInputTypePasswordAndNilStringNotNil() {
        let string = sut.verify(string: nil, type: .password)
        XCTAssertNil(string)
    }
    
    func testSutVerifyCallsWithInputTypePasswordAndEmptyStringNotNil() {
        let string = sut.verify(string: "", type: .password)
        XCTAssertNil(string)
    }
}

