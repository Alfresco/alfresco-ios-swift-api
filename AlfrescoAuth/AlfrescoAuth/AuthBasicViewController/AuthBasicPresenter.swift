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
            requestLogin(with: username, and: password) { (result) in
                switch result {
                case .failure(_): break
                    //
                case .success(let credential):
                    self.view?.success(credential: credential)
                    break
                }
                DispatchQueue.main.async {
                    self.authDelegate?.didReceive(result: result)
                }
            }
        }
    }
    
    func requestLogin(with username: String, and password: String, completionHandler: @escaping (Result<AlfrescoCredential, Error>) -> Void) {
        let core = AlfrescoCore()
        let builder = core.requestBuilder(baseURLString: baseURLString)
        let path = "/auth/realms/alfresco/protocol/openid-connect/token"
        let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let parameters: [String: String] = [ "grant_type": "password",
                                          "username": username,
                                          "password": password,
                                          "client_id": "alfresco"]
        let request = builder.request(method: .post, path: path, headerFields: headers, parameters: parameters)
        if let request = request {
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
               guard let data = data, let _ = response as? HTTPURLResponse, error == nil else {
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Request unavailable."])
                    completionHandler(Result.failure(error))
                    return
                }
                
                if let result = self.convertToDictionary(data: data) {
                    completionHandler(Result.success(AlfrescoCredential(with: result)))
                } else {
                    let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Converstion to dictonary failed."])
                    completionHandler(Result.failure(error))
                }
            }
            task.resume()
        } else {
            let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Request unavailable."])
            completionHandler(Result.failure(error))
        }
    }
    
    func convertToDictionary(data: Data) -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
