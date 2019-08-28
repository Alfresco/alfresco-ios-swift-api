//
//  AuthBasicViewController.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 16/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit

class AuthBasicViewController: UIViewController {
    
    @IBOutlet weak var userNameTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var userNameErrorLabel: UILabel!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: AuthBasicPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.view = self
    }
    
    //MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        presenter?.execute(username: userNameTextfield.text, password: passwordTextfield.text)
    }
}

extension AuthBasicViewController: AuthBasicViewProtocol {
    func success(credential: AlfrescoCredential) {
    }
    
    func display(alertError: UIAlertController) {
    }
    
    func display(errorMessage: String, type: InputType) {
        var textfield = UITextField()
        var label = UILabel()
        
        switch type {
        case .username:
            textfield = userNameTextfield
            label = userNameErrorLabel
            break
        case .password:
            textfield = passwordTextfield
            label = passwordErrorLabel
            break
        }
        
        label.text = errorMessage
        label.isHidden = false
        textfield.layer.borderColor = UIColor.red.cgColor
        textfield.layer.borderWidth = 1
    }
}

extension AuthBasicViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        var textfield = UITextField()
        var label = UILabel()
    
        switch textField {
        case userNameTextfield:
            textfield = userNameTextfield
            label = userNameErrorLabel
            break
        case passwordTextfield:
            textfield = passwordTextfield
            label = passwordErrorLabel
            break
        default:
            break
        }
        
        label.text = ""
        label.isHidden = true
        textfield.layer.borderColor = UIColor.clear.cgColor
        textfield.layer.borderWidth = 0
    }
}
