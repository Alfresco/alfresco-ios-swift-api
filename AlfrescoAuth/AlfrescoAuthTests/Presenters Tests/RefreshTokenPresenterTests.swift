//
//  RefreshTokenPresenterTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 14/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
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
            case .success(_):
                success = true
            case .failure(_):
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
            case .success(_):
                success = true
            case .failure(_):
                success = false
            }
            XCTAssertFalse(success)
        }
    }
}
