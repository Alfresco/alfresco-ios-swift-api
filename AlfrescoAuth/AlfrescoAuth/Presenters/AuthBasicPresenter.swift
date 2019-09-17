//
//  AuthBasicPresenter.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 16/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import UIKit
import AlfrescoCore

enum InputType {
    case username
    case password
}

class AuthBasicPresenter: NSObject, NetworkServiceProtocol {
    var authDelegate: AlfrescoAuthDelegate? = nil

    func verify(string: String?, type: InputType) -> String? {
        guard let string = string else {
            let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Field can't be empty!"])
            self.authDelegate?.didReceive(result: Result.failure(error))
            return nil
        }
        
        let stringTrim = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if stringTrim.isEmpty {
            let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Field can't be empty!"])
            self.authDelegate?.didReceive(result: Result.failure(error))
            return nil
        }
        return string
    }

    func execute(username: String?, password: String?) {
        let username = verify(string: username, type: .username)
        let password = verify(string: password, type: .password)
        if let username = username, let password = password {
            requestLogin(with: username, and: password) { [weak self] (result) in
                guard let sSelf = self else { return }
                DispatchQueue.main.async {
                    sSelf.authDelegate?.didReceive(result: result)
                }
            }
        }
    }
    
    func requestLogin(with username: String, and password: String, completion: @escaping (Result<AlfrescoCredential, Error>) -> Void) {
        _ = apiClient.send(GetAlfrescoCredential(username: username, password: password)) { (result) in
            completion(result)
        }
    }
}
