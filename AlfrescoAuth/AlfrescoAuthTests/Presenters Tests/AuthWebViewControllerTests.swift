//
// Copyright (C) 2005-2020 Alfresco Software Limited.
//
// This file is part of the Alfresco Content Mobile iOS App.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
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
        
        presenterDummy = AuthWebPresenterDummy(configuration: TestData.configuration)
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
}
