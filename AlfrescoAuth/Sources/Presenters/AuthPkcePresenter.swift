//
//  AuthAutoCodeExchangePresenter.swift
//  AlfrescoAuth
//
//  Created by Emanuel Lupu on 02/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AppAuth

public class AuthPkcePresenter {
    var configuration: AuthConfiguration
    var presentingViewController: UIViewController?
    var authSession: AlfrescoAuthSession?
    var authDelegate: AlfrescoAuthDelegate?
    
    init(configuration: AuthConfiguration) {
        self.configuration = configuration
    }
    
    func execute() {
        
        
    }
}
