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
        sut.presenter = presenterDummy
        
        userNameTextFieldStub = UITextFieldDummy()
        userNameTextFieldStub.text = TestData.username1
        sut.userNameTextfield = userNameTextFieldStub
        
        passwordTextFieldStub = UITextFieldDummy()
        passwordTextFieldStub.text = TestData.password1
        sut.passwordTextfield = passwordTextFieldStub
        
        sut.loginButtonTapped(UIButton())
        XCTAssertTrue(presenterDummy.didReceiveCalled)
    }
    
    func testSutDisplayErrorMessageForUsername() {
        let label = UILabel()
        let textfield = UITextField()
        sut.userNameErrorLabel = label
        sut.userNameTextfield = textfield
        sut.display(errorMessage: TestData.errorMessage1, type: .username)
        XCTAssertEqual(TestData.errorMessage1, label.text)
        XCTAssertFalse(label.isHidden)
        XCTAssertEqual(UIColor.red.cgColor, textfield.layer.borderColor)
        XCTAssertEqual(1, textfield.layer.borderWidth)
    }
    
    func testSutDisplayErrorMessageForPassword() {
        let label = UILabel()
        let textfield = UITextField()
        sut.passwordErrorLabel = label
        sut.passwordTextfield = textfield
        sut.display(errorMessage: TestData.errorMessage1, type: .password)
        XCTAssertEqual(TestData.errorMessage1, label.text)
        XCTAssertFalse(label.isHidden)
        XCTAssertEqual(UIColor.red.cgColor, textfield.layer.borderColor)
        XCTAssertEqual(1, textfield.layer.borderWidth)
    }
    
    func testSutDisplayAlertError() {
        sut.display(alertError: UIAlertController())
        XCTAssertNotNil(sut)
    }
    
    func testSutSuccessCredentials() {
        sut.success(credential: AlfrescoCredential())
        XCTAssertNotNil(sut)
    }
    
    func testSutTextFieldDidBeginEditingForUsername() {
        let textfield = UITextField()
        let label = UILabel()
        sut.userNameErrorLabel = label
        sut.userNameTextfield = textfield
        sut.textFieldDidBeginEditing(textfield)
        XCTAssertEqual("", label.text)
        XCTAssertTrue(label.isHidden)
        XCTAssertEqual(UIColor.clear.cgColor, textfield.layer.borderColor)
        XCTAssertEqual(0, textfield.layer.borderWidth)
    }
    
    func testSutTextFieldDidBeginEditingForPassword() {
        let textfield = UITextField()
        let label = UILabel()
        sut.passwordErrorLabel = label
        sut.passwordTextfield = textfield
        sut.textFieldDidBeginEditing(textfield)
        XCTAssertEqual("", label.text)
        XCTAssertTrue(label.isHidden)
        XCTAssertEqual(UIColor.clear.cgColor, textfield.layer.borderColor)
        XCTAssertEqual(0, textfield.layer.borderWidth)
    }
    
    func testSutTextFieldDidBeginEditingForDefault() {
        let textfield = UITextField()
        let label = UILabel()
        sut.textFieldDidBeginEditing(textfield)
        XCTAssertNil(label.text)
        XCTAssertFalse(label.isHidden)
        XCTAssertNotNil(textfield.layer.borderColor)
        XCTAssertEqual(0, textfield.layer.borderWidth)
    }
    
    //MARK: - Doubles
    class AuthBasicPresenterDummy: AuthBasicPresenter {
        var didReceiveCalled = false
        override func execute(username: String?, password: String?) {
            didReceiveCalled = true
        }
    }
    
    class UITextFieldDummy: UITextField { }
}
