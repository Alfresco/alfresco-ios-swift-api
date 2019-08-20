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
        navigationActionStub.sendTokenUrl = true
        let actionPolicy = sut.parse(action: navigationActionStub)
        XCTAssertEqual(actionPolicy, WKNavigationActionPolicy.cancel)
    }
    
    func testSutParseReturnWKNavigationActionPolicyAllow() {
        navigationActionStub.sendTokenUrl = false
        let actionPolicy = sut.parse(action: navigationActionStub)
        XCTAssertEqual(actionPolicy, WKNavigationActionPolicy.allow)
    }
    
    func testSutParseCallsAuthDelegateDidReceive() {
        let delegateStub = AlfrescoAuthDelegateStub()
        sut.authDelegate = delegateStub
        _ = sut.parse(action: navigationActionStub)
        XCTAssertTrue(delegateStub.didReceiveCalled)
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
        func didReceive(result: Result<AlfrescoCredential, Error>) {
            didReceiveCalled = true
        }
    }
    
    class WKNavigationActionStub: WKNavigationAction {
        var sendTokenUrl: Bool = true
        override var request: URLRequest {
            if sendTokenUrl {
                return URLRequest(url: URL(string: TestData.urlString)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 0)
            } else {
                return URLRequest(url: URL(string: TestData.urlStringWithoutAccesToken)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 0)
            }
        }
    }
}
