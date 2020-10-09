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

class AuthBasicPresenterTests: XCTestCase {
    var sut: AuthBasicPresenter!
    var expectationForDidReceivedCall = XCTestExpectation(description: "Wait for delegate.")
    var expectationForSuccessInDidReceivedCall = XCTestExpectation(description: "Success in DidReceivedCall")
    var expectationForFailureInDidReceivedCall = XCTestExpectation(description: "Failure in DidReceivedCall")
    
    override func setUp() {
        super.setUp()
        sut = AuthBasicPresenter(configuration: TestData.configuration)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testInitWithConfiguration() {
        sut = AuthBasicPresenter(configuration: TestData.configuration)
        XCTAssertEqual(sut.configuration, TestData.configuration)
    }
    
    func testExecuteWithSuccess() {
        let delegateStub = AlfrescoAuthDelegateStub()
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        
        apiClientSub.responseType = .validCredential
        delegateStub.expectationForDidReceivedCall = expectationForDidReceivedCall
        delegateStub.expectationForSuccessInDidReceivedCall = expectationForSuccessInDidReceivedCall
        
        sut.authDelegate = delegateStub
        sut.apiClient = apiClientSub
        sut.execute(username: TestData.username1, password: TestData.password1)
        
        wait(for: [expectationForDidReceivedCall, expectationForSuccessInDidReceivedCall], timeout: 10.0)
    }
    
    func testExecuteWithFailure() {
        let delegateStub = AlfrescoAuthDelegateStub()
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        
        apiClientSub.responseType = .error
        delegateStub.expectationForDidReceivedCall = expectationForDidReceivedCall
        delegateStub.expectationForFailureInDidReceivedCall = expectationForFailureInDidReceivedCall
        
        sut.authDelegate = delegateStub
        sut.apiClient = apiClientSub
        sut.execute(username: TestData.username1, password: TestData.password2)
        
        wait(for: [expectationForDidReceivedCall, expectationForFailureInDidReceivedCall], timeout: 10.0)
    }
    
    func testRequestTokenWithSuccess() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientSub.responseType = .validCredential
        sut.apiClient = apiClientSub
        sut.requestToken(with: TestData.username1, and: TestData.password1, completion: { (result) in
            var success = false
            switch result {
            case .success(_):
                success = true
            case .failure(_):
                success = false
            }
            XCTAssertTrue(success)
        })
    }
    
    func testRequestTokenWithFailure() {
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientSub.responseType = .error
        sut.apiClient = apiClientSub
        sut.requestToken(with: TestData.username1, and: TestData.password2, completion: { (result) in
            var success = false
            switch result {
            case .success(_):
                success = true
            case .failure(_):
                success = false
            }
            XCTAssertFalse(success)
        })
    }
    
    func testSutVerifyCallsWithInputTypeUsernameAndStringNotNil() {
        let string = sut.verify(string: TestData.username1, type: .username)
        XCTAssertNotNil(string)
    }
    
    func testSutVerifyCallsWithInputTypeUsernameAndNilStringNotNil() {
        let string = sut.verify(string: nil, type: .username)
        XCTAssertNil(string)
    }
    
    func testSutVerifyCallsWithInputTypeUsernameAndEmptyStringNotNil() {
        let string = sut.verify(string: "", type: .username)
        XCTAssertNil(string)
    }
    
    func testSutVerifyCallsWithInputTypePasswordAndStringNotNil() {
        let string = sut.verify(string: TestData.password1, type: .password)
        XCTAssertNotNil(string)
    }
    
    func testSutVerifyCallsWithInputTypePasswordAndNilStringNotNil() {
        let string = sut.verify(string: nil, type: .password)
        XCTAssertNil(string)
    }
    
    func testSutVerifyCallsWithInputTypePasswordAndEmptyStringNotNil() {
        let string = sut.verify(string: "", type: .password)
        XCTAssertNil(string)
    }
}

