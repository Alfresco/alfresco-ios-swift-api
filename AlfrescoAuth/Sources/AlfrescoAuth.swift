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
    
    var webPresenter: AuthWebPresenter
    var basicPresenter: AuthBasicPresenter
    var refreshPresenter: RefreshTokenPresenter
    var configuration: Configuration
    
    public init(baseURLString: String, realm: String, clientID: String, clientSecret: String = "") {
        configuration = Configuration(baseUrl: baseURLString, clientID: clientID, realm: realm, clientSecret: clientSecret)
        webPresenter = AuthWebPresenter(configuration: configuration)
        basicPresenter = AuthBasicPresenter(configuration: configuration)
        refreshPresenter = RefreshTokenPresenter(configuration: configuration)
    }
    
    public func webAuth(delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) -> UIViewController {
        webPresenter.authDelegate = alfrescoAuthDelegate
        let frameworkBundle = Bundle(for: AuthWebViewController.self)
        let storyboard = UIStoryboard(name: "Auth", bundle: frameworkBundle)
        let identifier = String(describing: AuthWebViewController.self)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! AuthWebViewController
        controller.presenter = webPresenter
        controller.urlString = String(format: kWebSAMLURLString, configuration.baseUrl, configuration.realm)
        return controller
    }
    
    public func basicAuth(username: String?, password: String?, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        basicPresenter.authDelegate = alfrescoAuthDelegate
        basicPresenter.execute(username: username, password: password)
    }
    
    public func refreshSession(credential: AlfrescoCredential, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        refreshPresenter.authDelegate = alfrescoAuthDelegate
        refreshPresenter.executeRefresh(credential)
    }
}

