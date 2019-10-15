//
//  AuthPkcePresenterTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 15/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
import AlfrescoCore
@testable import AlfrescoAuth

class AuthPkcePresenterTests: XCTestCase {
    var sut: AuthPkcePresenter!
    var expectationForDidRevicedCall = XCTestExpectation(description: "Wait for delegate.")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Success in DidRecivedCall")
    var expectationForFailureInDidRecivedCall = XCTestExpectation(description: "Failure in DidRecivedCall")
    
    override func setUp() {
        super.setUp()
        sut = AuthPkcePresenter(configuration: TestData.configuration)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testExecuteWithViewControllerNil() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationForDidRevicedCall = expectationForDidRevicedCall
        delegateStub.expectationForFailureInDidRecivedCall = expectationForFailureInDidRecivedCall
        
        sut.authDelegate = delegateStub
        sut.execute()
        
        wait(for: [expectationForDidRevicedCall, expectationForFailureInDidRecivedCall], timeout: 10.0)
    }
    
    func testExecuteWithWrongConfiguration() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationForDidRevicedCall = expectationForDidRevicedCall
        delegateStub.expectationForFailureInDidRecivedCall = expectationForFailureInDidRecivedCall
        
        sut.configuration.realm = "test"
        sut.authDelegate = delegateStub
        sut.presentingViewController = UIViewController()
        sut.execute()
        
        wait(for: [expectationForDidRevicedCall, expectationForFailureInDidRecivedCall], timeout: 10.0)
    }
}
