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

enum InputType: String {
    case username = "Username"
    case password = "Password"
}

class AuthBasicPresenter: NSObject, NetworkServiceProtocol {
    var authDelegate: AlfrescoAuthDelegate? = nil
    var apiClient = APIClient(with: kBaseURLString)

    func verify(string: String?, type: InputType) -> String? {
        guard let string = string else {
            self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "\(type.rawValue) field can't be empty!")))
            return nil
        }
        
        let stringTrim = string.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        if stringTrim.isEmpty {
            self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "\(type.rawValue) field can't be empty!")))
            return nil
        }
        return string
    }

    func execute(username: String?, password: String?) {
        let username = verify(string: username, type: .username)
        let password = verify(string: password, type: .password)
        if let username = username, let password = password {
            requestToken(with: username, and: password) { [weak self] (result) in
                guard let sSelf = self else { return }
                DispatchQueue.main.async {
                    sSelf.authDelegate?.didReceive(result: result)
                }
            }
        }
    }
    
    func requestToken(with username: String, and password: String, completion: @escaping (Result<AlfrescoCredential, Error>) -> Void) {
        _ = apiClient.send(GetAlfrescoCredential(username: username, password: password)) { (result) in
            completion(result)
        }
    }
}
