//
//  AuthWebPresenterTests.swift
//  AlfrescoAuthTests
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
import UIKit
import WebKit
@testable import AlfrescoAuth

class AuthWebPresenterTests: XCTestCase {
    var expectationForDidRevicedCall = XCTestExpectation(description: "Wait for delegate to login with SAML")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Delegate didReceivced call")
    var expectationForErrorInDidRecivedCall = XCTestExpectation(description: "Wait for delegate to get token with error with code.")
    var sut: AuthWebPresenter!
    var navigationActionStub: WKNavigationActionStub!

    override func setUp() {
        super.setUp()
        sut = AuthWebPresenter()
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

        navigationActionStub.sendCodeUrl = false
        sut.authDelegate = delegateStub
        _ = sut.parse(action: navigationActionStub)
        XCTAssertFalse(delegateStub.didReceiveCalled)
        wait(for: [expectationForDidRevicedCall, expectationForErrorInDidRecivedCall], timeout: 10.0)
    }
    
    func testRequestTokenReceiveAlfrescoCredential() {
        sut.requestToken(with: TestData.code) { (result) in
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
    
    //MARK: - Doubles
    
    class WebViewMock: WKWebView { }
    
    class AlfrescoAuthDelegateStub: AlfrescoAuthDelegate {
        var didReceiveCalled = false
        var expectationRequestLogin: XCTestExpectation!
        var expectationForDidRecivedCall: XCTestExpectation!
        var expectationForErrorInDidRecivedCall: XCTestExpectation!
        
        func didReceive(result: Result<AlfrescoCredential, Error>) {
            switch result {
            case .success(let cred):
                print(cred)
                expectationForDidRecivedCall.fulfill()
                didReceiveCalled = true
            case .failure(_):
                expectationForErrorInDidRecivedCall.fulfill()
                didReceiveCalled = false
            }
            expectationRequestLogin.fulfill()
        }
    }
    
    class WKNavigationActionStub: WKNavigationAction {
        var sendCodeUrl: Bool = true
        override var request: URLRequest {
            if sendCodeUrl {
                return URLRequest(url: URL(string: TestData.urlStringToLoadGood)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 0)
            } else {
                return URLRequest(url: URL(string: TestData.urlStringWithoutCode)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 0)
            }
        }
    }
}
