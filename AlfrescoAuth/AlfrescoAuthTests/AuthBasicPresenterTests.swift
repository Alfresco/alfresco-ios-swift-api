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
    
    func testSutParseCallsAuthDelegateDidReceiveAlfrescoCredential() {
        let delegateStub = AlfrescoAuthDelegateStub()
        sut.authDelegate = delegateStub
        sut.parse(username: TestData.username1, password: TestData.password1)
        XCTAssertTrue(delegateStub.didReceiveCalled)
    }
    
    func testSutParseCallsAuthDelegateDidReceiveError() {
        let delegateStub = AlfrescoAuthDelegateStub()
        sut.authDelegate = delegateStub
        sut.parse(username: TestData.username1, password: "")
        XCTAssertFalse(delegateStub.didReceiveCalled)
    }
    
    func testSutCheckNotEmptyCallTrue() {
        let check = sut.checkNotEmpty(TestData.username1, TestData.password1)
        XCTAssertTrue(check)
    }
    
    func testSutCheckNotEmptyCallFalse() {
        let check = sut.checkNotEmpty(TestData.username1, "")
        XCTAssertFalse(check)
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
