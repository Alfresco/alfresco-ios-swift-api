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
import Auth0

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
        guard let issuerURL = issuerURL() else {
            handler(.failure(nilIssuerError()))
            return
        }

        OIDAuthorizationService.discoverConfiguration(forIssuer: issuerURL) { [weak self] _, error in
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
        let authType = configuration.authType
        switch authType {
        case .auth0:
            getServerDetails(isLogin: true)
        default:
            keyClockLogin()
        }
    }
    
    func auth0login(auth0Config: OAuth2Data) {
        Auth0
            .webAuth(clientId: auth0Config.clientId ?? "", domain: auth0Config.host ?? "")
            .audience(auth0Config.audience ?? "")
            .scope(auth0Config.scope ?? "")
            .start {[weak self] result in
                guard let sSelf = self else { return }
                do {
                    switch result {
                    case .success(let credentials):
                        let credentialsDict = credentials.credentialDictionary()
                        let alfrescoCredentials = try AlfrescoCredential(from: credentialsDict)
                        sSelf.authDelegate?.didReceive(result: .success(alfrescoCredentials),
                                                       session: sSelf.authSession)
                        
                    case .failure(_):
                        let error = APIError(domain: moduleName,
                                             code: ModuleErrorType.errorAuthStateNil.code,
                                             message: errorAuthStateNil)
                        sSelf.authDelegate?.didReceive(result: .failure(error))
                    }
                } catch {
                    let error = APIError(domain: moduleName,
                                         code: ModuleErrorType.errorAuthStateNil.code,
                                         message: errorAuthStateNil)
                    sSelf.authDelegate?.didReceive(result: .failure(error))
                }
            }
    }
    
    func keyClockLogin() {
        guard let issuer = issuerURL() else {
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

            let request = OIDAuthorizationRequest(configuration: pkceConfiguration,
                                                  clientId: sSelf.configuration.clientID,
                                                  clientSecret: sSelf.configuration.clientSecret,
                                                  scopes: [OIDScopeOpenID],
                                                  redirectURL: URL(string: sSelf.configuration.redirectURI ?? "")!,
                                                  responseType: OIDResponseTypeCode,
                                                  additionalParameters: nil)

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
        let authType = configuration.authType
        switch authType {
        case .auth0:
            self.getServerDetails(isLogin: false)
        default:
            self.keyClockLogout(forCredential: credential)
        }
    }
    
    func keyClockLogout(forCredential credential: AlfrescoCredential) {
        guard let issuer = issuerURL() else {
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
    
    func getServerDetails(isLogin: Bool) {
        fetchAppConfig { [weak self] result in
            guard let sSelf = self else { return }
            switch result {
            case .success(let auth0Config):
                DispatchQueue.main.async {
                    if isLogin {
                        sSelf.auth0login(auth0Config: auth0Config)
                    } else {
                        sSelf.auth0Logout(auth0Config: auth0Config)
                    }
                }
            case .failure(let error):
                let error = APIError(domain: moduleName,
                                     code: ModuleErrorType.errorAuthStateNil.code,
                                     message: errorAuthStateNil)
                sSelf.authDelegate?.didReceive(result: .failure(error))
            }
        }
        
    }
    
    func auth0Logout(auth0Config: OAuth2Data) {
        Auth0
            .webAuth(clientId: auth0Config.clientId ?? "", domain: auth0Config.host ?? "")
            .audience(auth0Config.audience ?? "")
            .scope(auth0Config.scope ?? "")
            .clearSession { [weak self] result in
                guard let sSelf = self else { return }
                switch result {
                case .success:
                    sSelf.authDelegate?.didLogOut(result: .success(StatusCodes.code200OK.code))
                case .failure(let error):
                    sSelf.authDelegate?.didLogOut(result: .failure(APIError(domain: moduleName,
                                                                            code: StatusCodes.code403Forbidden.code,
                                                                            error: error )))
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

    func apiError(for error: NSError) -> APIError {
        return APIError(domain: moduleName,
                        code: error.code,
                        error: error)
    }
    
    func fetchAppConfig(completion: @escaping (Result<OAuth2Data, Error>) -> Void) {
        guard let url = URL(string: "\(self.configuration.baseUrl)/\(appConfig)") else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let err = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let appConfig = try decoder.decode(AppConfigDetails.self, from: data)
                
                if let oauth2Config = appConfig.oauth2 {
                    completion(.success(oauth2Config))
                } else {
                    let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey : "OAuth2 config not found"])
                    completion(.failure(error))
                }
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}

extension Credentials {
    func credentialDictionary() -> [String: Any] {
        var dictionary: [String: Any] = [:]
        dictionary["token_type"] = self.tokenType
        dictionary["access_token"] = self.accessToken
        dictionary["expires_in"] = Int(self.expiresIn.timeIntervalSince1970)
        dictionary["refresh_token"] = ""
        dictionary["id_token"] = self.idToken
        dictionary["session_state"] = ""
        dictionary["refresh_expires_in"] = 0
        return dictionary
    }
}

// Convert Dictionary to AlfrescoCredential using Decoder
extension AlfrescoCredential {
    init(from dictionary: [String: Any]) throws {
        let jsonData = try JSONSerialization.data(withJSONObject: dictionary, options: [])
        let decoder = JSONDecoder()
        self = try decoder.decode(AlfrescoCredential.self, from: jsonData)
    }
}
