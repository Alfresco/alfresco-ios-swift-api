//
//  AuthWebPresenterTests.swift
//  AlfrescoAuthTests
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
import WebKit
import AlfrescoCore
@testable import AlfrescoAuth

class AuthWebPresenterTests: XCTestCase {
    var sut: AuthWebPresenter!
    var navigationActionStub: WKNavigationActionStub!
    var expectationForDidRevicedCall = XCTestExpectation(description: "Wait for delegate.")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Success in DidRecivedCall")
    var expectationForFailureInDidRecivedCall = XCTestExpectation(description: "Failure in DidRecivedCall")
    
    override func setUp() {
        super.setUp()
        sut = AuthWebPresenter(configuration: TestData.configuration)
        navigationActionStub = WKNavigationActionStub()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInitWithConfiguration() {
        sut = AuthWebPresenter(configuration: TestData.configuration)
        XCTAssertEqual(sut.configuration, TestData.configuration)
    }
    
    func testSutParseReturnWKNavigationActionPolicyCancel() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood)
        sut.apiClient = apiClientSub
        navigationActionStub.sendCodeUrl = true
        
        let actionPolicy = sut.parse(action: navigationActionStub)
        XCTAssertEqual(actionPolicy, WKNavigationActionPolicy.cancel)
    }
    
    func testSutParseReturnWKNavigationActionPolicyAllow() {
        navigationActionStub.sendCodeUrl = false
        let actionPolicy = sut.parse(action: navigationActionStub)
        XCTAssertEqual(actionPolicy, WKNavigationActionPolicy.allow)
    }
    
    func testSutParseCallsWithSuccess() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood)
        let delegateStub = AlfrescoAuthDelegateStub()
        
        delegateStub.expectationForDidRevicedCall = expectationForDidRevicedCall
        delegateStub.expectationForSuccessInDidRecivedCall = expectationForSuccessInDidRecivedCall
        apiClientSub.successResponse = true
        sut.apiClient = apiClientSub
        navigationActionStub.sendCodeUrl = true
        sut.authDelegate = delegateStub
        
        _ = sut.parse(action: navigationActionStub)
        wait(for: [expectationForDidRevicedCall, expectationForSuccessInDidRecivedCall], timeout: 10.0)
    }
    
    func testSutParseCallsWithFailure() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood)
        let delegateStub = AlfrescoAuthDelegateStub()
        
        delegateStub.expectationForDidRevicedCall = expectationForDidRevicedCall
        delegateStub.expectationForFailureInDidRecivedCall = expectationForFailureInDidRecivedCall
        apiClientSub.successResponse = false
        sut.apiClient = apiClientSub
        navigationActionStub.sendCodeUrl = true
        sut.authDelegate = delegateStub
        
        _ = sut.parse(action: navigationActionStub)
        wait(for: [expectationForDidRevicedCall, expectationForFailureInDidRecivedCall], timeout: 10.0)
    }
    
    func testRequestTokenWithSuccess() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood)
        apiClientSub.successResponse = true
        sut.apiClient = apiClientSub
        sut.requestToken(with: TestData.codeGood) { (result) in
            var success = false
            switch result {
            case .success(_):
                success = true
            case .failure(_):
                success = false
            }
            XCTAssertTrue(success)
        }
    }
    
    func testRequestTokenWithFailure() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood)
        apiClientSub.successResponse = false
        sut.apiClient = apiClientSub
        sut.requestToken(with: TestData.codeGood) { (result) in
            var success = false
            switch result {
            case .success(_):
                success = true
            case .failure(_):
                success = false
            }
            XCTAssertFalse(success)
        }
    }
    
    func testSutWKNavigationDelegateNavigationAction() {
           let webViewMock = WebViewMock()
           webViewMock.navigationDelegate = sut
           webViewMock.navigationDelegate?.webView?(webViewMock, decidePolicyFor: navigationActionStub, decisionHandler: { (actionPolicy) in
               XCTAssertNotNil(actionPolicy)
           })
       }
}

/*
import XCTest
import UIKit
import WebKit
import AlfrescoCore
@testable import AlfrescoAuth

class AuthWebPresenterTests: XCTestCase {
    var expectationForDidRevicedCall = XCTestExpectation(description: "Wait for delegate to login with SAML")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Delegate didReceivced call")
    var expectationForErrorInDidRecivedCall = XCTestExpectation(description: "Wait for delegate to get token with error with code.")
    var sut: AuthWebPresenter!
    var navigationActionStub: WKNavigationActionStub!

    override func setUp() {
        super.setUp()
        sut = AuthWebPresenter(configuration: TestData.configuration)
        navigationActionStub = WKNavigationActionStub()
    }

    override func tearDown() {
        sut = nil
        navigationActionStub = nil
        super.tearDown()
    }

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testSutParseReturnWKNavigationActionPolicyCancel() {
        navigationActionStub.sendCodeUrl = true
        let actionPolicy = sut.parse(action: navigationActionStub)
        XCTAssertEqual(actionPolicy, WKNavigationActionPolicy.cancel)
    }
    
    func testSutParseReturnWKNavigationActionPolicyAllow() {
        navigationActionStub.sendCodeUrl = false
        let actionPolicy = sut.parse(action: navigationActionStub)
        XCTAssertEqual(actionPolicy, WKNavigationActionPolicy.allow)
    }
    
    func testSutParseCallsAuthDelegateDidReceiveErrorFromServer() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationRequestLogin = expectationForDidRevicedCall
        delegateStub.expectationForErrorInDidRecivedCall = expectationForErrorInDidRecivedCall

        navigationActionStub.sendCodeUrl = true
        sut.authDelegate = delegateStub
        _ = sut.parse(action: navigationActionStub)
        XCTAssertFalse(delegateStub.didReceiveCalled)
        wait(for: [expectationForDidRevicedCall, expectationForErrorInDidRecivedCall], timeout: 10.0)
    }
    
    func testRequestTokenReceiveAlfrescoCredential() {
        sut.requestToken(with: TestData.codeGood) { (result) in
            switch result {
            case .success(_): 
                self.expectationForSuccessInDidRecivedCall.fulfill()
            case .failure(let error): print(error) 
            }
            self.expectationForDidRevicedCall.fulfill()
        }
        wait(for: [expectationForDidRevicedCall, expectationForSuccessInDidRecivedCall], timeout: 10.0)
    }
    
    func testSutWKNavigationDelegateNavigationAction() {
        let webViewMock = WebViewMock()
        webViewMock.navigationDelegate = sut
        webViewMock.navigationDelegate?.webView?(webViewMock, decidePolicyFor: navigationActionStub, decisionHandler: { (actionPolicy) in
            XCTAssertNotNil(actionPolicy)
        })
    }
    

}
 */
