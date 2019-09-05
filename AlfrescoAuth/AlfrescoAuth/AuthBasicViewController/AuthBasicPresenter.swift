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

class AuthBasicPresenter: NSObject {
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
            requestLogin(with: username, and: password) { (result) in
                DispatchQueue.main.async {
                    self.authDelegate?.didReceive(result: result)
                }
            }
        }
    }
    
    func requestLogin(with username: String, and password: String, completionHandler: @escaping (Result<AlfrescoCredential, Error>) -> Void) {
        let core = AlfrescoCore()
        let builder = core.requestBuilder(baseURLString: baseURLString)
        let path = tokenEndpoint
        let headers = ["Content-Type": ContentType.urlencoded]
        let parameters: [String: String] = ["grant_type": "password",
                                            "client_id": clientID,
                                            "client_secret": clientSecret,
                                            "username": username,
                                            "password": password,]
        
        let request = builder.request(method: .post, path: path, headerFields: headers, parameters: parameters)
        
        _ = builder.start(request: request) { (result) in
            switch result {
            case .success(let model):
                let credential = AlfrescoCredential.init(with: model)
                completionHandler(Result.success(credential))
                break
            case .failure(let error):
                completionHandler(Result.failure(error))
                break
            }
        }
    }
}
