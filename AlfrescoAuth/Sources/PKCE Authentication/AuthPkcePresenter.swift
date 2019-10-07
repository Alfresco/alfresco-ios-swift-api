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
        guard let issuer = URL(string: String(format: kIssuerPKCE, configuration.baseUrl, configuration.realm)) else {
            self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Can't create issuer from base url!")))
            return
        }
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) {  [weak self] pkceConfiguration, error in
            guard let sSelf = self else { return }
            guard let viewController = sSelf.presentingViewController else { return }
            if let error = error {
                sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, error: error)))
                return
            }
            guard let pkceConfiguration = pkceConfiguration else {
                sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Can't create issuer from base url!")))
                return
            }
            let request = OIDAuthorizationRequest(configuration: pkceConfiguration,
                                                  clientId: sSelf.configuration.clientID,
                                                  clientSecret: sSelf.configuration.clientSecret,
                                                  scopes: [OIDScopeOpenID],
                                                  redirectURL: URL(string: sSelf.configuration.redirectURI ?? "")!,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)

            sSelf.authSession?.authorizationFlow = OIDAuthState.authState(byPresenting: request, presenting: viewController) { authState, error in
                if let error = error {
                    sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, error: error)))
                    return
                }
                guard let authState = authState else {
                    sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Can't authentificate!")))
                    return
                }
                sSelf.authSession?.authState = authState
                sSelf.authDelegate?.didReceive(result: .success(AlfrescoCredential(with: authState.lastTokenResponse)))
            }
        }
    }
    
    func executeRefreshSession() {
        if let authState = self.authSession?.authState {
            authState.performAction { [weak self] (accessToken, idTOken, error) in
                guard let sSelf = self else { return }
                if let error = error {
                    sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, error: error)))
                    return
                }
                
                guard accessToken != nil else {
                    sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Failed to retrieve access a fresh access token")))
                    return
                }
                
                sSelf.authDelegate?.didReceive(result: .success(AlfrescoCredential(with: authState.lastTokenResponse)))
            }
        }
    }
}
