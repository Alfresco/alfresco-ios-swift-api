//
//  AuthProvider.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit
import AlfrescoCore

public enum AuthViewControllerType {
    case web
}

public protocol AlfrescoAuthDelegate {
    func didReceive(result: Result<AlfrescoCredential, APIError>)
}

public struct AlfrescoAuth {
    
    var webPresenter: AuthWebPresenter?
    var basicPresenter: AuthBasicPresenter?
    var refreshPresenter: RefreshTokenPresenter?
    var pkcePresenter: AuthPkcePresenter?
    
    var configuration: AuthConfiguration
    
    public init(configuration: AuthConfiguration) {
        self.configuration = configuration
    }
    
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
    
    public mutating func basicAuth(username: String?, password: String?, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        basicPresenter = AuthBasicPresenter(configuration: configuration)
        basicPresenter?.authDelegate = alfrescoAuthDelegate
        basicPresenter?.execute(username: username, password: password)
    }
    
    public mutating func refreshSession(credential: AlfrescoCredential, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        refreshPresenter = RefreshTokenPresenter(configuration: configuration)
        refreshPresenter?.authDelegate = alfrescoAuthDelegate
        refreshPresenter?.executeRefresh(credential)
    }
    
    public mutating func pkceAuth(onViewController viewController: UIViewController, delegate: AlfrescoAuthDelegate) -> AlfrescoAuthSession {
        pkcePresenter = AuthPkcePresenter(configuration: configuration)
        pkcePresenter?.presentingViewController = viewController
        pkcePresenter?.authDelegate = delegate
        
        let authSession = AlfrescoAuthSession()
        pkcePresenter?.authSession = authSession
        
        pkcePresenter?.execute()
        
        return authSession
    }
}

