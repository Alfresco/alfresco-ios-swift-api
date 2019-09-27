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
    
    var webPresenter: AuthWebPresenter = AuthWebPresenter()
    var basicPresenter: AuthBasicPresenter = AuthBasicPresenter()
    var refreshPresenter: RefreshTokenPresenter = RefreshTokenPresenter()
    
    public init() { }
    
    public func webAuth(with urlStringToLoad: String? = nil, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) -> UIViewController {
        webPresenter.authDelegate = alfrescoAuthDelegate
        let frameworkBundle = Bundle(for: AuthWebViewController.self)
        let storyboard = UIStoryboard(name: "Auth", bundle: frameworkBundle)
        let identifier = String(describing: AuthWebViewController.self)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as! AuthWebViewController
        /*
         //This line is for iOS 13.0
         let controller = storyboard.instantiateViewController(identifier: identifier) as AuthWebViewController
         */
        controller.presenter = webPresenter
        controller.urlString = urlStringToLoad
        return controller
    }
    
    public func basicAuth(with username: String?, and password: String?, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        basicPresenter.authDelegate = alfrescoAuthDelegate
        basicPresenter.execute(username: username, password: password)
    }
    
    public func refreshSession(_ credential: AlfrescoCredential, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        refreshPresenter.authDelegate = alfrescoAuthDelegate
        refreshPresenter.executeRefresh(credential)
    }
}

