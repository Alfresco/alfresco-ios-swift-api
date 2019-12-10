//
//  LogoutPresenter.swift
//  AlfrescoAuth
//
//  Created by Emanuel Lupu on 06/12/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public class LogoutPresenter {
    var configuration: AuthConfiguration
    var authDelegate: AlfrescoAuthDelegate?
    var apiClient: APIClientProtocol
    
    init(configuration: AuthConfiguration) {
        self.configuration = configuration
        self.apiClient = APIClient(with: configuration.baseUrl)
    }
    
    func execute() {
        _ = apiClient.send(LogoutRequest(serviceDocumentInstanceURL: configuration.baseUrl), completion: { [weak self] result in
            guard let sSelf = self else { return }
            
            switch result {
            case .success(let status):
                sSelf.authDelegate?.didLogOut(result: .success(status.responseCode))
                
            case .failure(let error):
                sSelf.authDelegate?.didLogOut(result: .failure(error))
            }
        })
    }
}
