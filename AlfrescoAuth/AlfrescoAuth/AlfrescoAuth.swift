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
    case basic
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
            let controller = storyboard.instantiateViewController(identifier: "AuthWebViewController") as AuthWebViewController
            controller.presenter = presenter
            controller.urlString = urlStringToLoad
            return controller
        case .basic:
            return UIViewController()
        }
    }
}

