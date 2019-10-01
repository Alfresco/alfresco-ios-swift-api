//
//  AuthBasicPresenter.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 16/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit
import XCTest
import AlfrescoCore
@testable import AlfrescoAuth

class AuthBasicPresenterTests: XCTestCase {
    var sut: AuthBasicPresenter!
    
    var expectationForDidRevicedCall = XCTestExpectation(description: "Delegate didReceivced call")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Wait for delegate to login with success with username and password.")
    var expectationForErrorInDidRecivedCall = XCTestExpectation(description: "Wait for delegate to login with error with wrong username or password.")
    
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
    
    func testSutExecuteCallsAuthDelegateDidReceiveAlfrescoCredential() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationRequestLogin = expectationForDidRevicedCall
        delegateStub.expectationForSuccessInDidRecivedCall = expectationForSuccessInDidRecivedCall
        
        sut.authDelegate = delegateStub
        sut.execute(username: TestData.username1, password: TestData.password1)
        
        wait(for: [expectationForDidRevicedCall, expectationForSuccessInDidRecivedCall], timeout: 10.0)
    }
    
    func testSutExecuteCallsAuthDelegateDidReceiveErrorFromServer() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationRequestLogin = expectationForDidRevicedCall
        delegateStub.expectationForErrorInDidRecivedCall = expectationForErrorInDidRecivedCall

        sut.authDelegate = delegateStub
        sut.execute(username: TestData.username1, password: TestData.password2)
        
        wait(for: [expectationForDidRevicedCall, expectationForErrorInDidRecivedCall], timeout: 10.0)
    }
    
    
    func testSutExecuteCallsAuthDelegateDidReceiveErrorWithEmptyString() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationRequestLogin = expectationForDidRevicedCall
        delegateStub.expectationForErrorInDidRecivedCall = expectationForErrorInDidRecivedCall
        
        sut.authDelegate = delegateStub
        sut.execute(username: TestData.username1, password: "")
        XCTAssertFalse(delegateStub.didReceiveCalled)
        wait(for: [expectationForDidRevicedCall, expectationForErrorInDidRecivedCall], timeout: 10.0)
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
    
    //MARK: - Doubles
    
    class AlfrescoAuthDelegateStub: AlfrescoAuthDelegate {
        var didReceiveCalled = false
        var expectationRequestLogin: XCTestExpectation!
        var expectationForSuccessInDidRecivedCall: XCTestExpectation!
        var expectationForErrorInDidRecivedCall: XCTestExpectation!
        
        func didReceive(result: Result<AlfrescoCredential, APIError>) {
            switch result {
            case .success(let cred):
                print(cred)
                expectationForSuccessInDidRecivedCall.fulfill()
                didReceiveCalled = true
            case .failure(_):
                expectationForErrorInDidRecivedCall.fulfill()
                didReceiveCalled = false
            }
            expectationRequestLogin.fulfill()
        }
    }
}
