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
    var expectationForDidReceivedCall = XCTestExpectation(description: "Wait for did receive call.")
    var expectationForSuccessInDidReceivedCall = XCTestExpectation(description: "Success in DidRecivedCall")
    var expectationForFailureInDidReceivedCall = XCTestExpectation(description: "Failure in DidRecivedCall")
    
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
        delegateStub.expectationForDidReceivedCall = expectationForDidReceivedCall
        delegateStub.expectationForFailureInDidReceivedCall = expectationForFailureInDidReceivedCall
        
        sut.authDelegate = delegateStub
        sut.execute()
        
        wait(for: [expectationForDidReceivedCall, expectationForFailureInDidReceivedCall], timeout: 10.0)
    }
    
    func testExecuteWithWrongConfiguration() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationForDidReceivedCall = expectationForDidReceivedCall
        delegateStub.expectationForFailureInDidReceivedCall = expectationForFailureInDidReceivedCall
        
        sut.configuration.realm = "test"
        sut.authDelegate = delegateStub
        sut.presentingViewController = UIViewController()
        sut.execute()
        
        wait(for: [expectationForDidReceivedCall, expectationForFailureInDidReceivedCall], timeout: 10.0)
    }
}
