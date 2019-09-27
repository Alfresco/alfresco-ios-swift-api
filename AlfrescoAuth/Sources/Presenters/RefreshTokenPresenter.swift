//
//  RefreshTokenPresenter.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 13/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AlfrescoCore

class RefreshTokenPresenter: NSObject, NetworkServiceProtocol {
    var authDelegate: AlfrescoAuthDelegate? = nil
    var apiClient = APIClient(with: kBaseURLString)
    
    func executeRefresh(_ credential: AlfrescoCredential) {
        requestToken(with: credential) { [weak self] (result) in
            guard let sSelf = self else { return } 
            DispatchQueue.main.async {
                sSelf.authDelegate?.didReceive(result: result)
            }
        }
    }
    
    func requestToken(with credential: AlfrescoCredential, completion: @escaping (Result<AlfrescoCredential, APIError>) -> Void) {
        _ = apiClient.send(GetAlfrescoCredential(refreshToken: credential.refreshToken), completion: { (result) in
            completion(result)
        })
    }
}
