//
//  AlfrescoAuthTests.swift
//  AlfrescoAuthTests
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import XCTest
@testable import AlfrescoAuth

class AlfrescoAuthTests: XCTestCase {
    
    var expectationForDidRevicedCall = XCTestExpectation(description: "Delegate didReceivced call")
    var expectationForSuccessInDidRecivedCall = XCTestExpectation(description: "Wait for delegate to login with success with username and password.")
    var expectationForErrorInDidRecivedCall = XCTestExpectation(description: "Wait for delegate to login with error with wrong username or password.")
    var sut: AlfrescoAuth!

    override func setUp() {
        super.setUp()
        sut = AlfrescoAuth()
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    //MARK: - SAML web auth tests
    func testGetAuthViewControllerOfTypeWebIsAAuthWebViewController() {
        let viewController = sut.getAuthViewController(ofType: .web, delegate: AlfrescoAuthDelegateStub())
        XCTAssert(viewController.isKind(of: AuthWebViewController.self))
    }
    
    func testGetAuthViewControllerOfTypeWebSetsAuthDelegateOnPresenter() {
        let viewController = sut.getAuthViewController(ofType: .web, delegate: AlfrescoAuthDelegateStub()) as! AuthWebViewController
        XCTAssertNotNil(viewController.presenter?.authDelegate)
    }
    
    func testGetAuthViewControllerOfTypeWebSetsURLStringToLoad() {
        let viewController = sut.getAuthViewController(ofType: .web, urlStringToLoad: TestData.urlStringToLoadGood, delegate: AlfrescoAuthDelegateStub()) as! AuthWebViewController
        XCTAssertNotNil(TestData.urlStringToLoadGood, viewController.urlString!)
    }
    
    func testGetAuthWithSuccess() {
        let delegateStub = AlfrescoAuthDelegateStub()
        delegateStub.expectationRequestLogin = expectationForDidRevicedCall
        delegateStub.expectationForSuccessInDidRecivedCall = expectationForSuccessInDidRecivedCall
        sut.auth(with: TestData.username1, and: TestData.password1, delegate: delegateStub)
    
        wait(for: [expectationForDidRevicedCall, expectationForSuccessInDidRecivedCall], timeout: 10.0)
    }
    

    //MARK: - Doubles
    class AlfrescoAuthDelegateStub: AlfrescoAuthDelegate {
        var didReceiveCalled = false
        var expectationRequestLogin: XCTestExpectation!
        var expectationForSuccessInDidRecivedCall: XCTestExpectation!
        var expectationForErrorInDidRecivedCall: XCTestExpectation!
        
        func didReceive(result: Result<AlfrescoCredential, Error>) {
            switch result {
            case .success(let cred):
                print(cred)
                expectationForSuccessInDidRecivedCall.fulfill()
                didReceiveCalled = true
            case .failure(_):
                expectationForErrorInDidRecivedCall.fulfill()
                didReceiveCalled = false
            }
            expectationRequestLogin.fulfill()
        }
    }
}
