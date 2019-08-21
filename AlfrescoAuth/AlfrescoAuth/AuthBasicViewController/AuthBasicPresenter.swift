//
//  AuthBasicPresenter.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 16/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

class AuthBasicPresenter: NSObject {
    var authDelegate: AlfrescoAuthDelegate? = nil
    
    func parse(username: String?, password: String?) {
        if let username = username, let password = password {
            if checkNotEmpty(username, password) {
                //TODO: Core Module
                let alfrescoCredentials = AlfrescoCredential()
                authDelegate?.didReceive(result: .success(alfrescoCredentials))
            } else {
                //TODO: Core Module
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Empty credentials!"])
                authDelegate?.didReceive(result: .failure(error))
            }
        }
    }
    
    //MARK: - Utils
    func checkNotEmpty(_ username: String, _ password: String) -> Bool {
        if username != "" && password != "" && username.isEmpty == false && password.isEmpty == false {
            return true
        }
        return false
    }
}
