//
//  AuthBasicViewControllerTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 16/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit
import XCTest
@testable import AlfrescoAuth

class AuthBasicViewControllerTests: XCTestCase {
    var sut: AuthBasicViewController!
    var presenterDummy: AuthBasicPresenterDummy!
    var userNameTextFieldStub: UITextFieldDummy!
    var passwordTextFieldStub: UITextFieldDummy!
    
    override func setUp() {
        super.setUp()
        sut = AuthBasicViewController()
        presenterDummy = AuthBasicPresenterDummy()
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testSutViewDidLoad() {
        sut.viewDidLoad()
        XCTAssertNotNil(sut)
    }
    
    func testSutLoginButton() {
        let delegateStub = AlfrescoAuthDelegateStub()
        sut.presenter = presenterDummy
        presenterDummy.authDelegate = delegateStub
        
        userNameTextFieldStub = UITextFieldDummy()
        userNameTextFieldStub.text = TestData.username1
        sut.userNameTextfield = userNameTextFieldStub
        
        passwordTextFieldStub = UITextFieldDummy()
        passwordTextFieldStub.text = TestData.password1
        sut.passwordTextfield = passwordTextFieldStub
        
        sut.loginButtonTapped(UIButton())
        XCTAssertTrue(delegateStub.didReceiveCalled)
    }
    
    //MARK: - Doubles
    class AuthBasicPresenterDummy: AuthBasicPresenter { }
    
    class UITextFieldDummy: UITextField { }
    
    class AlfrescoAuthDelegateStub: AlfrescoAuthDelegate {
        var didReceiveCalled = false
        func didReceive(result: Result<AlfrescoCredential, Error>) {
            switch result {
            case .success(_):
                didReceiveCalled = true
            case .failure(_):
                didReceiveCalled = false
            }
        }
    }
}
