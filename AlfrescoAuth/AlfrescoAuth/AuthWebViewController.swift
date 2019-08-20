//
//  AuthWebViewController.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import UIKit
import WebKit

class AuthWebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var presenter: AuthWebPresenter?
    var urlString: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = presenter
        if let url = URL(string: urlString ?? "") {
            webView.load(URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData))
        }
    }
}
