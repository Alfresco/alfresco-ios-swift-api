//
//  RefreshTokenPresenter.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 13/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

class RefreshTokenPresenter: NSObject, NetworkServiceProtocol {
    var authDelegate: AlfrescoAuthDelegate? = nil
    
    func executeRefresh(_ credential: AlfrescoCredential) {
        requestRefresh(with: credential) { [weak self] (result) in
            guard let sSelf = self else { return } 
            DispatchQueue.main.async {
                sSelf.authDelegate?.didReceive(result: result)
            }
        }
    }
    
    func requestRefresh(with credential: AlfrescoCredential, completion: @escaping (Result<AlfrescoCredential, Error>) -> Void) {
        _ = apiClient.send(GetAlfrescoCredential(refreshToken: credential.refreshToken), completion: { (result) in
            completion(result)
        })
    }
}
