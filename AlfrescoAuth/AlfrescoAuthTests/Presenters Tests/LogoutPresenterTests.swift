//
//  LogoutPresenterTests.swift
//  AlfrescoAuthTests
//
//  Created by Emanuel Lupu on 09/12/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
@testable import AlfrescoAuth

class LogoutPresenterTests: XCTestCase {
    var sut: LogoutPresenter!

    var expectationForSuccessInLogoutCall = XCTestExpectation(description: "Success in LogoutCall")
    var expectationForFailureInLogoutCall = XCTestExpectation(description: "Failure in LogoutCall")

    override func setUp() {
        super.setUp()
        sut = LogoutPresenter(configuration: TestData.configuration)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }

    func testThatItLogsOutSuccessfully() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationForSuccessInDidLogoutCall = expectationForSuccessInLogoutCall

        let apiClientStub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientStub.responseType = .validResponseCode

        sut.authDelegate = delegateStub
        sut.apiClient = apiClientStub

        sut.execute()

        wait(for: [expectationForSuccessInLogoutCall], timeout: 1.0)
    }

    func testThatItFailsToLogOutSuccessfully() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationForFailureInDidLogoutCall = expectationForFailureInLogoutCall

        let apiClientStub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientStub.responseType = .error

        sut.authDelegate = delegateStub
        sut.apiClient = apiClientStub

        sut.execute()

        wait(for: [expectationForFailureInLogoutCall], timeout: 1.0)
    }
}
