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

import Foundation
import XCTest
import AlfrescoCore
@testable import AlfrescoAuth

class RefreshTokenPresenterTests: XCTestCase {
    var sut: RefreshTokenPresenter!
    var expectationForDidReceivedCall = XCTestExpectation(description: "Wait for delegate.")
    var expectationForSuccessInDidReceivedCall = XCTestExpectation(description: "Success in DidReceivedCall")
    var expectationForFailureInDidReceivedCall = XCTestExpectation(description: "Failure in DidReceivedCall")

    override func setUp() {
        super.setUp()
        sut = RefreshTokenPresenter(configuration: TestData.configuration)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }

    func testInitWithConfiguration() {
        sut = RefreshTokenPresenter(configuration: TestData.configuration)
        XCTAssertEqual(sut.configuration, TestData.configuration)
    }

    func testExecuteRefreshWithSuccess() {
        let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        let delegateStub = AlfrescoAuthDelegateStub()
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))

        apiClientSub.responseType = .validCredential
        delegateStub.expectationForDidReceivedCall = expectationForDidReceivedCall
        delegateStub.expectationForSuccessInDidReceivedCall = expectationForSuccessInDidReceivedCall

        sut.authDelegate = delegateStub
        sut.apiClient = apiClientSub
        sut.executeRefresh(alfrescoCredential)

        wait(for: [expectationForDidReceivedCall, expectationForSuccessInDidReceivedCall], timeout: 10.0)
    }

    func testExecuteRefreshWithFailure() {
        let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        let delegateStub = AlfrescoAuthDelegateStub()
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))

        apiClientSub.responseType = .error
        delegateStub.expectationForDidReceivedCall = expectationForDidReceivedCall
        delegateStub.expectationForFailureInDidReceivedCall = expectationForFailureInDidReceivedCall

        sut.authDelegate = delegateStub
        sut.apiClient = apiClientSub
        sut.executeRefresh(alfrescoCredential)

        wait(for: [expectationForDidReceivedCall, expectationForFailureInDidReceivedCall], timeout: 10.0)
    }

    func testRequestTokenWithSuccess() {
        let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientSub.responseType = .validCredential
        sut.apiClient = apiClientSub
        sut.requestToken(with: alfrescoCredential) { (result) in
            var success = false
            switch result {
            case .success:
                success = true
            case .failure:
                success = false
            }
            XCTAssertTrue(success)
        }
    }

    func testRequestTokenWithFailure() {
        let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientSub.responseType = .error
        sut.apiClient = apiClientSub
        sut.requestToken(with: alfrescoCredential) { (result) in
            var success = false
            switch result {
            case .success:
                success = true
            case .failure:
                success = false
            }
            XCTAssertFalse(success)
        }
    }
}
