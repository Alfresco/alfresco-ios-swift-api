//
//  AuthAutoCodeExchangePresenter.swift
//  AlfrescoAuth
//
//  Created by Emanuel Lupu on 02/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AppAuth
import AlfrescoCore

public enum AvailableAuthType {
    case basicAuth
    case aimsAuth
}

public class AuthPkcePresenter {
    var configuration: AuthConfiguration
    var presentingViewController: UIViewController?
    var authSession: AlfrescoAuthSession?
    var authDelegate: AlfrescoAuthDelegate?
    var apiClient: APIClientProtocol
    
    private var userAgent: OIDExternalUserAgentIOS?
    private var logoutSession: OIDExternalUserAgentSession?
    
    init(configuration: AuthConfiguration) {
        self.configuration = configuration
        self.apiClient = APIClient(with: configuration.baseUrl)
    }
    
    func availableAuthType(for issuer: String, handler: @escaping((Result<AvailableAuthType, APIError>) -> Void)) {
        guard let issuerURL = URL(string: String(format: kIssuerPKCE, configuration.baseUrl, configuration.realm)) else {
            handler(.failure(APIError(domain: moduleName, message: "Can't create issuer from base url!")))
            return
        }
        
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuerURL) {[weak self] pkceConfiguration, error in
            guard let sSelf = self else { return }
            
            if error != nil {
                // Check if the request succeeds for an instance configured with basic auth
                _ = sSelf.apiClient.send(HeadServiceDocumentInstance(serviceDocumentInstanceURL: issuer), completion: { (result) in
                    switch result {
                    case .success(_):
                        handler(.success(.basicAuth))
                    case .failure(_):
                        handler(.failure(APIError(domain: moduleName, message: "No authentication service can be found at the provided AlfrescoURL")))
                    }
                })
            } else {
                handler(.success(.aimsAuth))
            }
        }
    }
    
    func execute() {
        guard let issuer = URL(string: String(format: kIssuerPKCE, configuration.baseUrl, configuration.realm)) else {
            self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Can't create issuer from base url!")))
            return
        }
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) {  [weak self] pkceConfiguration, error in
            guard let sSelf = self else { return }
            guard let viewController = sSelf.presentingViewController else {
                sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "ViewController is nil!")))
                return
            }
            if let error = error as NSError? {
                sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, code: error.code, error: error)))
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
                if let error = error as NSError? {
                    sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, code: error.code, error: error)))
                    return
                }
                guard let authState = authState else {
                    sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Can't authentificate!")))
                    return
                }
                sSelf.authSession?.authState = authState
                sSelf.authDelegate?.didReceive(result: .success(AlfrescoCredential(with: authState.lastTokenResponse)), session: sSelf.authSession)
            }
        }
    }
    
    func logout(forCredential credential: AlfrescoCredential) {
        guard let issuer = URL(string: String(format: kIssuerPKCE, configuration.baseUrl, configuration.realm)) else {
            self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Can't create issuer from base url!")))
            return
        }
        
        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) {  [weak self] pkceConfiguration, error in
            guard let sSelf = self else { return }
            
            guard let viewController = sSelf.presentingViewController else {
                sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "ViewController is nil!")))
                return
            }
            
            if let error = error as NSError? {
                sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, code: error.code, error: error)))
                return
            }
            guard let pkceConfiguration = pkceConfiguration else {
                sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Can't create issuer from base url!")))
                return
            }
            
            let logoutRequest = OIDEndSessionRequest(configuration: pkceConfiguration,
                                                     idTokenHint: credential.accessToken ?? "",
                                                     postLogoutRedirectURL: URL(string: sSelf.configuration.redirectURI ?? "")!,
                                                     state: (self?.authSession?.authState?.lastAuthorizationResponse.state) ?? "",
                                                     additionalParameters: nil)
            
            sSelf.userAgent = OIDExternalUserAgentIOS(presenting: viewController)
            if let userAgent = sSelf.userAgent {
                sSelf.logoutSession = OIDAuthorizationService.present(logoutRequest,
                                                                      externalUserAgent: userAgent,
                                                                      callback: { [weak self] (authorizationState, error) in
                                                                        guard let sSelf = self else { return }
                                                                        
                                                                        if let authError = error as NSError?  {
                                                                            sSelf.authDelegate?.didLogOut(result: .failure(APIError(domain: moduleName, code: authError.code, error: authError )))
                                                                        } else {
                                                                            sSelf.authDelegate?.didLogOut(result: .success(StatusCodes.Code200OK.code))
                                                                        }
                })
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
                    sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Failed to retrieve a fresh access token")))
                    return
                }
                
                sSelf.authDelegate?.didReceive(result: .success(AlfrescoCredential(with: authState.lastTokenResponse)), session: sSelf.authSession)
            }
        }
    }
}
