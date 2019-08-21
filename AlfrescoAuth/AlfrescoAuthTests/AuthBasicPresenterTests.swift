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
        sut.authDelegate = delegateStub
        sut.execute(username: TestData.username1, password: TestData.password1)
        XCTAssertTrue(delegateStub.didReceiveCalled)
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
        func didReceive(result: Result<AlfrescoCredential, Error>) {
            switch result {
            case .success(_):
                didReceiveCalled = true
            case .failure(_):
                didReceiveCalled = false
            }
        }
    }
}
