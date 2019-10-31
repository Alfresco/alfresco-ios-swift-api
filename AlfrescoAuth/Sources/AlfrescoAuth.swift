//
//  AuthProvider.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit
import AlfrescoCore


/// Delegate of the AlfrescoAuth module used to monitor responses coming from the Identity Service.
public protocol AlfrescoAuthDelegate {
    
    /** Called when a response coming from the Identity Service is available.
    - Parameter result: Object containing token related information  used to authorize further requests or an optional error parameter.
    */
    func didReceive(result: Result<AlfrescoCredential, APIError>)
}

public struct AlfrescoAuth {
    // Presenters
    var webPresenter: AuthWebPresenter?
    var basicPresenter: AuthBasicPresenter?
    var refreshPresenter: RefreshTokenPresenter?
    var pkcePresenter: AuthPkcePresenter?
    
    // Configuration
    var configuration: AuthConfiguration
    
    
    /** Designated initializer of the AlfrescoAuthModule.
    - Parameter configuration: Identity Service related configuration parameters.
    */
    public init(configuration: AuthConfiguration) {
        self.configuration = configuration
    }
    
    /** Alternative method used to authenticate with Identity Service when it is set up to work with an exernal provider that invokes the use of web view components.
    - Parameter alfrescoAuthDelegate: Delegate used to report the state and response of the authentication request
    */
    public mutating func webAuth(delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) -> UIViewController {
        webPresenter = AuthWebPresenter(configuration: configuration)
        webPresenter?.authDelegate = alfrescoAuthDelegate
        
        let frameworkBundle = Bundle(for: AuthWebViewController.self)
        let storyboard = UIStoryboard(name: "Auth", bundle: frameworkBundle)
        let identifier = String(describing: AuthWebViewController.self)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! AuthWebViewController
        
        controller.presenter = webPresenter
        controller.urlString = String(format: kWebSAMLURLString, configuration.baseUrl, configuration.realm)
        
        return controller
    }
    
    /** Alternative method used to authenticate with Identity Service when it is set up to work with Basic Auth.
    - Parameter username: Username for which the authentication request is created
    - Parameter password: Password for which the authentication request is created
    - Parameter alfrescoAuthDelegate: Delegate used to report the state and response of the authentication request
    */
    public mutating func basicAuth(username: String?, password: String?, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        basicPresenter = AuthBasicPresenter(configuration: configuration)
        basicPresenter?.authDelegate = alfrescoAuthDelegate
        basicPresenter?.execute(username: username, password: password)
    }
    
    /** Alternative method used to refresh session with Identity service.
    - Remark: Works with all the provided authentication methods in AlfrescoAuth
    - Parameter credential: Object containing token related information
    - Parameter alfrescoAuthDelegate: Delegate used to report the state and response of the authentication request
    */
    public mutating func refreshSession(credential: AlfrescoCredential, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        refreshPresenter = RefreshTokenPresenter(configuration: configuration)
        refreshPresenter?.authDelegate = alfrescoAuthDelegate
        refreshPresenter?.executeRefresh(credential)
    }
    
    /** Designated safe authetication method with Identity Service using PKCE protocol.
    - Parameter viewController: Thew view controller from which to present the SFSafariViewController.
    - Parameter delegate: Delegate used to report the state and response of the authentication request
    */
    public mutating func pkceAuth(onViewController viewController: UIViewController, delegate: AlfrescoAuthDelegate) -> AlfrescoAuthSession {
        pkcePresenter = AuthPkcePresenter(configuration: configuration)
        pkcePresenter?.presentingViewController = viewController
        pkcePresenter?.authDelegate = delegate
        
        let authSession = AlfrescoAuthSession()
        pkcePresenter?.authSession = authSession
        
        pkcePresenter?.execute()
        
        return authSession
    }
    
    /** Given a path component,  it returns via a closure the available authentication type for the base URL defined in the AlfrescoConfiguration
     object and the defined path. If the path is not defined, then only the base URL will be used as reference.
     - Parameter serviceDocument: service path for which the authentication type check is performed
     - Parameter handler: Closure delivering updates on the authentication type. Possible values are base auth, AIMS and an optional error
     */
    public mutating func availableAuthType(for serviceDocument: String = "", handler:@escaping ((Result<AvailableAuthType, APIError>) -> Void)) {
        pkcePresenter = AuthPkcePresenter(configuration: configuration)
        pkcePresenter?.availableAuthType(for: serviceDocument, handler: { result in
            handler(result)
        })
    }
    
    /** Designated safe session refresh method with Identity Service  using PKCE protocol.
    - Parameter alfrescoAuthDelegate: Delegate used to report the state and response of the re-authentication request
    */
    public mutating func pkceRefreshSession(delegate: AlfrescoAuthDelegate) {
        pkcePresenter?.authDelegate = delegate
        pkcePresenter?.executeRefreshSession()
    }
}

