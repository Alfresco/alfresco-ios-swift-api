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
    
    public init() { }
    
    public func getAuthViewController(ofType type:AuthViewControllerType, urlStringToLoad: String? = nil, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) -> UIViewController {
        switch type {
        case .web:
            let presenter = AuthWebPresenter()
            presenter.authDelegate = alfrescoAuthDelegate
            
            let frameworkBundle = Bundle(for: AuthWebViewController.self)
            let storyboard = UIStoryboard(name: "Auth", bundle: frameworkBundle)
            let controller = storyboard.instantiateViewController(identifier: String(describing: AuthWebViewController.self)) as AuthWebViewController
            controller.presenter = presenter
            controller.urlString = urlStringToLoad
            return controller
        }
    }
    
    public func auth(with username: String, and password: String, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        let presenter = AuthBasicPresenter()
        presenter.authDelegate = alfrescoAuthDelegate
        presenter.execute(username: username, password: password)
    }
    
    public func refreshSession(_ credential: AlfrescoCredential, delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        let presenter = RefreshTokenPresenter()
        presenter.authDelegate = alfrescoAuthDelegate
        presenter.executeRefresh(credential)
    }
}

