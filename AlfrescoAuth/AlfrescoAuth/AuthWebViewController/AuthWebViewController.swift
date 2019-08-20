//
//  AuthWebViewController.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit
import WebKit

class AuthWebViewController : UIViewController {
    var presenter : AuthWebPresenter? {
        didSet {
            self.setDelegates()
        }
    }
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func setDelegates() {
        webView.navigationDelegate = presenter
    }
}
