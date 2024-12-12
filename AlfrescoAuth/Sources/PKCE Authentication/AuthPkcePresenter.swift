//
// Copyright (C) 2005-2020 Alfresco Software Limited.
//
// This file is part of the Alfresco Content Mobile iOS App.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import AppAuth
import AlfrescoCore

public enum AvailableAuthType: String, Codable {
    case basicAuth = "Basic Auth"
    case aimsAuth = "KeyClock"
    case auth0 = "Auth0"
    
    public init?(rawValue: String) {
            switch rawValue.lowercased() {
            case "basic auth":
                self = .basicAuth
            case "keyclock":
                self = .aimsAuth
            case "auth0":
                self = .auth0
            default:
                return nil
            }
        }
}

public class AuthPkcePresenter {
    var configuration: AuthConfiguration
    var presentingViewController: UIViewController?
    var authSession: AlfrescoAuthSession?
    weak var authDelegate: AlfrescoAuthDelegate?
    var apiClient: APIClientProtocol

    private var logoutUserAgent: OIDExternalUserAgentIOSSafari?

    init(configuration: AuthConfiguration) {
        self.configuration = configuration
        self.apiClient = APIClient(with: configuration.baseUrl)
    }

    func availableAuthType(handler: @escaping((Result<AvailableAuthType, APIError>) -> Void)) {
        
        let issuerURL = (self.configuration.authType == .auth0) ? auth0IssuerURL() : issuerURL()

        guard let issuer = issuerURL else {
            handler(.failure(nilIssuerError()))
            return
        }

        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { [weak self] _, error in
            guard let sSelf = self else { return }

            if error != nil {
                // Check if the request succeeds for an instance configured with basic auth
                let url = sSelf.configuration.baseUrl
                let getPathRequest = GetPathInstance(pathInstanceURL: url)
                _ = sSelf.apiClient.send(getPathRequest, completion: { (result) in
                    switch result {
                    case .success:
                        handler(.success(.basicAuth))
                    case .failure:
                        let error = APIError(domain: moduleName,
                                             code: ModuleErrorType.errorAuthenticationServiceNotFound.code,
                                             message: errorAuthenticationServiceNotFound)
                        handler(.failure(error))
                    }
                })
            } else {
                handler(.success(.aimsAuth))
            }
        }
    
    }

    func execute() {
        let issuerURL = (self.configuration.authType == .auth0) ? auth0IssuerURL() : issuerURL()

        guard let issuer = issuerURL else {
            self.authDelegate?.didReceive(result: .failure(nilIssuerError()))
            return
        }

        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) {[weak self] pkceConfiguration, error in
            guard let sSelf = self else { return }

            guard let viewController = sSelf.presentingViewController else {
                sSelf.authDelegate?.didReceive(result: .failure(sSelf.nilViewControllerError()))
                return
            }

            if let error = error as NSError? {
                sSelf.authDelegate?.didReceive(result: .failure(sSelf.apiError(for: error)))
                return
            }

            guard let pkceConfiguration = pkceConfiguration else {
                sSelf.authDelegate?.didReceive(result: .failure(sSelf.nilIssuerError()))
                return
            }
            
            let additionalParameters = (sSelf.configuration.authType == .auth0) ? ["audience": sSelf.configuration.realm ?? "", "prompt": "login"] : nil


            let request = OIDAuthorizationRequest(configuration: pkceConfiguration,
                                                  clientId: sSelf.configuration.clientID,
                                                  clientSecret: sSelf.configuration.clientSecret,
                                                  scopes: [OIDScopeOpenID, OIDScopeProfile, OIDScopeEmail],
                                                  redirectURL: URL(string: sSelf.configuration.redirectURI ?? "")!,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: additionalParameters)

            sSelf.authSession?.authorizationFlow =
                OIDAuthState.authState(byPresenting: request,
                                       presenting: viewController) { authState, error in
                    if let error = error as NSError? {
                        sSelf.authDelegate?.didReceive(result: .failure(sSelf.apiError(for: error)))
                        return
                    }
                    guard let authState = authState else {
                        let error = APIError(domain: moduleName,
                                             code: ModuleErrorType.errorAuthStateNil.code,
                                             message: errorAuthStateNil)
                        sSelf.authDelegate?.didReceive(result: .failure(error))
                        return
                    }

                    sSelf.authSession?.authState = authState
                    let credential = AlfrescoCredential(with: authState.lastTokenResponse)
                    sSelf.authDelegate?.didReceive(result: .success(credential),
                                                   session: sSelf.authSession)
                }
        }
    }
    
    func logout(forCredential credential: AlfrescoCredential) {
        
        let issuerURL = (self.configuration.authType == .auth0) ? auth0IssuerURL() : issuerURL()

        guard let issuer = issuerURL else {
            self.authDelegate?.didReceive(result: .failure(nilIssuerError()))
            return
        }

        OIDAuthorizationService.discoverConfiguration(forIssuer: issuer) { [weak self] pkceConfiguration, error in
            guard let sSelf = self else { return }

            guard let viewController = sSelf.presentingViewController else {
                sSelf.authDelegate?.didReceive(result: .failure(sSelf.nilViewControllerError()))
                return
            }

            if let error = error as NSError? {
                sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName,
                                                                         code: error.code,
                                                                         error: error)))
                return
            }
            guard let pkceConfiguration = pkceConfiguration else {
                sSelf.authDelegate?.didReceive(result: .failure(sSelf.nilIssuerError()))
                return
            }
            
            let logoutRequest =
                OIDEndSessionRequest(configuration: pkceConfiguration,
                                     idTokenHint: credential.idToken ?? "",
                                     postLogoutRedirectURL: URL(string: sSelf.configuration.redirectURI ?? "")!,
                                     state: (sSelf.authSession?.authState?.lastAuthorizationResponse.state) ?? "",
                                     additionalParameters: nil)
            
            

            sSelf.logoutUserAgent =
                OIDExternalUserAgentIOSSafari(presentingViewController: viewController)

            if let userAgent = sSelf.logoutUserAgent {
                sSelf.authSession?.authorizationFlow =
                    OIDAuthorizationService.present(
                        logoutRequest,
                        externalUserAgent: userAgent,
                        callback: {[weak self] (_, error) in
                            guard let sSelf = self else { return }

                            if let authError = error as NSError? {
                                sSelf.authDelegate?.didLogOut(result: .failure(APIError(domain: moduleName,
                                                                                        code: authError.code,
                                                                                        error: authError )))
                            } else {
                                sSelf.authDelegate?.didLogOut(result: .success(StatusCodes.code200OK.code))
                            }
                        })
            }
        }
    }
        
    func executeRefreshSession() {
        if let authState = self.authSession?.authState {
            authState.performAction { [weak self] (accessToken, _, error) in
                guard let sSelf = self else { return }
                if let error = error {
                    sSelf.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName,
                                                                             error: error)))
                    return
                }

                guard accessToken != nil else {
                    let error = APIError(domain: moduleName,
                                         code: ModuleErrorType.errorRetriveFreshToken.code,
                                         message: errorRetriveFreshToken)
                    sSelf.authDelegate?.didReceive(result: .failure(error))
                    return
                }

                let credential = AlfrescoCredential(with: authState.lastTokenResponse)
                sSelf.authDelegate?.didReceive(result: .success(credential),
                                               session: sSelf.authSession)
            }
        }
    }

    // MARK: - Private interface

    func nilIssuerError() -> APIError {
        return APIError(domain: moduleName,
                        code: ModuleErrorType.errorIssuerNil.code,
                        message: errorIssuerNil)
    }

    func nilViewControllerError() -> APIError {
        return APIError(domain: moduleName,
                        code: ModuleErrorType.errorViewControllerNil.code,
                        message: errorViewControllerNil)
    }

    func issuerURL() -> URL? {
        return URL(string: String(format: kIssuerPKCE,
                                  configuration.baseUrl,
                                  configuration.realm))
    }
    
    func auth0IssuerURL() -> URL? {
        return URL(string: configuration.baseUrl)
    }

    func apiError(for error: NSError) -> APIError {
        return APIError(domain: moduleName,
                        code: error.code,
                        error: error)
    }
    
}
