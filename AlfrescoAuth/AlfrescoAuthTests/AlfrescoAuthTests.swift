//
//  AlfrescoAuthTests.swift
//  AlfrescoAuthTests
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
import AlfrescoCore
@testable import AlfrescoAuth

class AlfrescoAuthTests: XCTestCase {
    var sut: AlfrescoAuth!
    var expectationForDidRevicedCall = XCTestExpectation(description: "Wait for delegate.")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Success in DidRecivedCall")
    var expectationForFailureInDidRecivedCall = XCTestExpectation(description: "Failure in DidRecivedCall")

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
        _ = sut.pkceAuth(onViewController: viewController, delegate: AlfrescoAuthDelegateStub())
        XCTAssertNotNil(sut.pkcePresenter)
        XCTAssertNotNil(sut.pkcePresenter?.authDelegate)
    }
    
    func testPckeAuthReturnsAlfrescoAuthSession() {
        let viewController = UIViewController()
        let alfrescoAuthSession = sut.pkceAuth(onViewController: viewController, delegate: AlfrescoAuthDelegateStub())
        XCTAssertNotNil(alfrescoAuthSession)
    }
    
    func testPckeRefreshSessionhSetsPresenter() {
        let viewController = UIViewController()
        _ = sut.pkceAuth(onViewController: viewController, delegate: AlfrescoAuthDelegateStub())
        sut.pkceRefreshSession(delegate: AlfrescoAuthDelegateStub())
        
        XCTAssertNotNil(sut.pkcePresenter)
        XCTAssertNotNil(sut.pkcePresenter?.authDelegate)
    }
}
