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
    @IBOutlet weak var loginButton: UIButton!
    
    var presenter: AuthBasicPresenter?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - IBActions
    @IBAction func loginButtonTapped(_ sender: UIButton) {
        presenter?.parse(username: userNameTextfield.text, password: passwordTextfield.text)
    }
}
