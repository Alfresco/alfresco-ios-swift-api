//
//  AuthBasicPresenter.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 16/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit
import XCTest
@testable import AlfrescoAuth

class AuthBasicPresenterTests: XCTestCase {
    var sut: AuthBasicPresenter!
    
    var expectationForDidRevicedCall = XCTestExpectation(description: "Wait for delegate to login with username and password.")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Delegate direceivced call")
    
    override func setUp() {
        super.setUp()
        sut = AuthBasicPresenter()
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
        delegateStub.expectationForDidRecivedCall = expectationForSuccessInDidRecivedCall
        
        sut.authDelegate = delegateStub
        sut.execute(username: TestData.username1, password: TestData.password1)
        
        wait(for: [expectationForDidRevicedCall, expectationForSuccessInDidRecivedCall], timeout: 10.0)
    }
    
    func testSutExecuteCallsAuthDelegateDidReceiveErrorWithEmptyString() {
        let delegateStub = AlfrescoAuthDelegateStub()
        sut.authDelegate = delegateStub
        sut.execute(username: TestData.username1, password: "")
        XCTAssertFalse(delegateStub.didReceiveCalled)
    }
    
    func testSutExecuteCallsAuthDelegateDidReceiveErrorWithNilString() {
        let delegateStub = AlfrescoAuthDelegateStub()
        sut.authDelegate = delegateStub
        sut.execute(username: TestData.username1, password: nil)
        XCTAssertFalse(delegateStub.didReceiveCalled)
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
        var expectationForDidRecivedCall: XCTestExpectation!
        
        func didReceive(result: Result<AlfrescoCredential, Error>) {
            switch result {
            case .success(_):
                expectationForDidRecivedCall.fulfill()
                didReceiveCalled = true
            case .failure(_):
                didReceiveCalled = false
            }
            expectationRequestLogin.fulfill()
        }
    }
}
