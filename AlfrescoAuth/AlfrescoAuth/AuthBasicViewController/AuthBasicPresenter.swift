//
//  AuthBasicPresenter.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 16/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import UIKit

class AuthBasicPresenter: NSObject {
    var authDelegate: AlfrescoAuthDelegate? = nil
    var view: AuthBasicViewProtocol? = nil

    func verify(string: String?, type: InputType) -> String? {
        guard let string = string else {
            view?.display(errorMessage: "Field can't be empty!", type: type)
            return nil
        }
        
        let stringTrim = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if stringTrim.isEmpty {
            view?.display(errorMessage: "Field can't be empty!", type: type)
            return nil
        }
        return string
    }

    func execute(username: String?, password: String?) {
        let username = verify(string: username, type: .username)
        let password = verify(string: password, type: .password)
        if let username = username, let password = password {
            print("Username and password is valid!")
            //TODO: Core Module request call with username/password
            let alfrescoCredentials = AlfrescoCredential()
            authDelegate?.didReceive(result: .success(alfrescoCredentials))
        }
    }
}
