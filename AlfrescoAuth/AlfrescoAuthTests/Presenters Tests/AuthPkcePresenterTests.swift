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
