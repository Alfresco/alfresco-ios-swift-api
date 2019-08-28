//
//  AuthWebViewControllerTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 06/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import WebKit
import UIKit
import XCTest
@testable import AlfrescoAuth

class AuthWebViewControllerTests: XCTestCase {
    var sut: AuthWebViewController!
    var webViewMock: WebViewMock!
    var presenterDummy: AuthWebPresenterDummy!
    
    override func setUp() {
        super.setUp()
        sut = AuthWebViewController()
        
        webViewMock = WebViewMock()
        sut.webView = webViewMock
        
        presenterDummy = AuthWebPresenterDummy()
        sut.presenter = presenterDummy
    }

    override func tearDown() {
        sut = nil
        webViewMock = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testSutViewDidLoadSetsWebViewNavigationDelegate() {
        sut.viewDidLoad()
        XCTAssertNotNil(webViewMock.navigationDelegate)
    }
    
    func testSutViewDidLoadLoadsURLString() {
        sut.urlString = TestData.urlStringToLoadGood
        sut.viewDidLoad()
        XCTAssertTrue(webViewMock.loadWasCalled)
        XCTAssertEqual(TestData.urlStringToLoadGood, webViewMock.urlString)
    }
    
    // MARK: - Doubles
    
    class WebViewMock: WKWebView {
        var loadWasCalled = false
        var urlString = ""
        
        override func load(_ request: URLRequest) -> WKNavigation? {
            loadWasCalled = true
            urlString = request.url?.absoluteString ?? ""
            return super.load(request)
        }
    }
    
    class AuthWebPresenterDummy: AuthWebPresenter { }
    
    struct AlfrescoAuthDelegateDummy: AlfrescoAuthDelegate{
        func didReceive(result: Result<AlfrescoCredential, Error>) { }
    }
}
