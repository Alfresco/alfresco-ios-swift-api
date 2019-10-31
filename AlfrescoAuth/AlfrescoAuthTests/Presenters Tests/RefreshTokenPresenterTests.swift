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
    var expectationForDidRevicedCall = XCTestExpectation(description: "Wait for delegate.")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Success in DidRecivedCall")
    var expectationForFailureInDidRecivedCall = XCTestExpectation(description: "Failure in DidRecivedCall")
    
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
        
        apiClientSub.successResponse = true
        delegateStub.expectationForDidRevicedCall = expectationForDidRevicedCall
        delegateStub.expectationForSuccessInDidRecivedCall = expectationForSuccessInDidRecivedCall
        
        sut.authDelegate = delegateStub
        sut.apiClient = apiClientSub
        sut.executeRefresh(alfrescoCredential)
        
        wait(for: [expectationForDidRevicedCall, expectationForSuccessInDidRecivedCall], timeout: 10.0)
    }
    
    func testExecuteRefreshWithFailure() {
        let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        let delegateStub = AlfrescoAuthDelegateStub()
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        
        apiClientSub.successResponse = false
        delegateStub.expectationForDidRevicedCall = expectationForDidRevicedCall
        delegateStub.expectationForFailureInDidRecivedCall = expectationForFailureInDidRecivedCall
        
        sut.authDelegate = delegateStub
        sut.apiClient = apiClientSub
        sut.executeRefresh(alfrescoCredential)
        
        wait(for: [expectationForDidRevicedCall, expectationForFailureInDidRecivedCall], timeout: 10.0)
    }
    
    func testRequestTokenWithSuccess() {
        let alfrescoCredential = AlfrescoCredential(with: TestData.dictionaryAlfrescoCredentialGood)
        let apiClientSub = APIClientStub(with: TestData.baseUrlGood, session: URLSession(configuration: .default))
        apiClientSub.successResponse = true
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
        apiClientSub.successResponse = false
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
