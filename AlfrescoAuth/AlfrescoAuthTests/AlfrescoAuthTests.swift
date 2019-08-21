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
        let viewController = sut.getAuthViewController(ofType: .web, delegate: AlfrescoAuthDelegateDummy())
        XCTAssert(viewController.isKind(of: AuthWebViewController.self))
    }
    
    func testGetAuthViewControllerOfTypeWebSetsAuthDelegateOnPresenter() {
        let viewController = sut.getAuthViewController(ofType: .web, delegate: AlfrescoAuthDelegateDummy()) as! AuthWebViewController
        XCTAssertNotNil(viewController.presenter?.authDelegate)
    }
    
    func testGetAuthViewControllerOfTypeWebSetsURLStringToLoad() {
        let viewController = sut.getAuthViewController(ofType: .web, urlStringToLoad: TestData.urlStringToLoad, delegate: AlfrescoAuthDelegateDummy()) as! AuthWebViewController
        XCTAssertNotNil(TestData.urlStringToLoad, viewController.urlString!)
    }
    
    //MARK: - Basic auth tests
    func testGetAuthViewControllerOfTypeBasicIsAUIViewController() {
        let viewController = sut.getAuthViewController(ofType: .basic, delegate: AlfrescoAuthDelegateDummy())
        XCTAssert(viewController.isKind(of: UIViewController.self))
    }
    
    func testGetBasicViewControllerOfTypeBasicSetsAuthDelegateOnPresenter() {
       let viewController = sut.getAuthViewController(ofType: .basic, delegate: AlfrescoAuthDelegateDummy()) as! AuthBasicViewController
       XCTAssertNotNil(viewController.presenter?.authDelegate)
   }

    //MARK: - Doubles
    struct AlfrescoAuthDelegateDummy: AlfrescoAuthDelegate {
        func didReceive(result: Result<AlfrescoCredential, Error>) { }
    }
}
