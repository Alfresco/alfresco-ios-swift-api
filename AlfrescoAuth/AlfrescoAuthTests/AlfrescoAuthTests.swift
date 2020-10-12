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

import XCTest
import AlfrescoCore
@testable import AlfrescoAuth

class AlfrescoAuthTests: XCTestCase {
    var sut: AlfrescoAuth!

    override func setUp() {
        super.setUp()
        sut = AlfrescoAuth(configuration: TestData.configuration)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testWebAuthReturnsAuthWebViewController() {
        let viewController = sut.webAuth(delegate: AlfrescoAuthDelegateStub())
        XCTAssert(viewController.isKind(of: AuthWebViewController.self))
    }
    
    func testWebAuthSetsURLString() {
        let viewController = sut.webAuth(delegate: AlfrescoAuthDelegateStub()) as! AuthWebViewController
        XCTAssertNotNil(TestData.urlStringToLoadGood, viewController.urlString!)
    }
    
    func testWebAuthSetsAuthDelegateToViewController() {
        let viewController = sut.webAuth(delegate: AlfrescoAuthDelegateStub()) as! AuthWebViewController
        XCTAssertNotNil(viewController.presenter?.authDelegate)
    }
    
    func testWebAuthSetsPresenter() {
        _ = sut.webAuth(delegate: AlfrescoAuthDelegateStub())
        XCTAssertNotNil(sut.webPresenter)
        XCTAssertNotNil(sut.webPresenter?.authDelegate)
    }
    
    func testBasicAuthSetsPresenter() {
        sut.basicAuth(username: TestData.username1, password: TestData.password1, delegate: AlfrescoAuthDelegateStub())
        XCTAssertNotNil(sut.basicPresenter)
        XCTAssertNotNil(sut.basicPresenter?.authDelegate)
    }
    
    func testRefreshSessionSetsPresenter() {
        let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        sut.refreshSession(credential: alfrescoCredential, delegate: AlfrescoAuthDelegateStub())
        XCTAssertNotNil(sut.refreshPresenter)
        XCTAssertNotNil(sut.refreshPresenter?.authDelegate)
    }
    
    func testPckeAuthSetsPresenter() {
        let viewController = UIViewController()
        sut.pkceAuth(onViewController: viewController, delegate: AlfrescoAuthDelegateStub())
        XCTAssertNotNil(sut.pkcePresenter)
        XCTAssertNotNil(sut.pkcePresenter?.authDelegate)
    }
    
    func testPckeRefreshSessionhSetsPresenter() {
        let viewController = UIViewController()
        sut.pkceAuth(onViewController: viewController, delegate: AlfrescoAuthDelegateStub())
        sut.pkceRefresh(session: AlfrescoAuthSession(), delegate: AlfrescoAuthDelegateStub())
        
        XCTAssertNotNil(sut.pkcePresenter)
        XCTAssertNotNil(sut.pkcePresenter?.authDelegate)
    }
}
