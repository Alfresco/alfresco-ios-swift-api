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
        if let viewController = sut.webAuth(delegate: AlfrescoAuthDelegateStub()) {
            XCTAssert(viewController.isKind(of: AuthWebViewController.self))
        }
    }

    func testWebAuthSetsURLString() {
        let delegate = AlfrescoAuthDelegateStub()
        guard let viewController = sut.webAuth(delegate: delegate) as? AuthWebViewController else { return }
        XCTAssertNotNil(TestData.urlStringToLoadGood, viewController.urlString!)
    }

    func testWebAuthSetsAuthDelegateToViewController() {
        let delegate = AlfrescoAuthDelegateStub()
        let viewController = sut.webAuth(delegate: delegate) as? AuthWebViewController
        XCTAssertNotNil(viewController?.presenter?.authDelegate)
    }

    func testWebAuthSetsPresenter() {
        let delegate = AlfrescoAuthDelegateStub()
        _ = sut.webAuth(delegate: delegate)
        XCTAssertNotNil(sut.webPresenter)
        XCTAssertNotNil(sut.webPresenter?.authDelegate)
    }

    func testBasicAuthSetsPresenter() {
        let delegate = AlfrescoAuthDelegateStub()
        sut.basicAuth(username: TestData.username1,
                      password: TestData.password1,
                      delegate: delegate)
        XCTAssertNotNil(sut.basicPresenter)
        XCTAssertNotNil(sut.basicPresenter?.authDelegate)
    }

    func testRefreshSessionSetsPresenter() {
        let delegate = AlfrescoAuthDelegateStub()
        let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        sut.refreshSession(credential: alfrescoCredential, delegate: delegate)
        XCTAssertNotNil(sut.refreshPresenter)
        XCTAssertNotNil(sut.refreshPresenter?.authDelegate)
    }

    func testPckeAuthSetsPresenter() {
        let viewController = UIViewController()
        let delegate = AlfrescoAuthDelegateStub()
        sut.pkceAuth(onViewController: viewController, delegate: delegate)
        XCTAssertNotNil(sut.pkcePresenter)
        XCTAssertNotNil(sut.pkcePresenter?.authDelegate)
    }

    func testPckeRefreshSessionhSetsPresenter() {
        let viewController = UIViewController()
        let delegate = AlfrescoAuthDelegateStub()
        sut.pkceAuth(onViewController: viewController, delegate: delegate)
        sut.pkceRefresh(session: AlfrescoAuthSession(), delegate: delegate)

        XCTAssertNotNil(sut.pkcePresenter)
        XCTAssertNotNil(sut.pkcePresenter?.authDelegate)
    }
}
