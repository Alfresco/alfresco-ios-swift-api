//
//  AuthProvider.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit

public enum AuthViewControllerType {
    case web
}

public protocol AlfrescoAuthDelegate {
    func didReceive(result: Result<AlfrescoCredential, Error>)
}

public struct AlfrescoAuth {
    
    var webPresenter: AuthWebPresenter = AuthWebPresenter()
    var basicPresenter: AuthBasicPresenter = AuthBasicPresenter()
    var refreshPresenter: RefreshTokenPresenter = RefreshTokenPresenter()
    
    public init() { }
    
    public func getAuthViewController(ofType type:AuthViewControllerType, urlStringToLoad: String? = nil, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) -> UIViewController {
        switch type {
        case .web:
            webPresenter.authDelegate = alfrescoAuthDelegate
            let frameworkBundle = Bundle(for: AuthWebViewController.self)
            let storyboard = UIStoryboard(name: "Auth", bundle: frameworkBundle)
            let controller = storyboard.instantiateViewController(withIdentifier: String(describing: AuthWebViewController.self)) as! AuthWebViewController
            /*
             //This line is for iOS 13.0
            let controller = storyboard.instantiateViewController(identifier: String(describing: AuthWebViewController.self)) as AuthWebViewController
             */
            controller.presenter = webPresenter
            controller.urlString = urlStringToLoad
            return controller
        }
    }
    
    public func auth(with username: String?, and password: String?, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        basicPresenter.authDelegate = alfrescoAuthDelegate
        basicPresenter.execute(username: username, password: password)
    }
    
    public func refreshSession(_ credential: AlfrescoCredential, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        refreshPresenter.authDelegate = alfrescoAuthDelegate
        refreshPresenter.executeRefresh(credential)
    }
}

