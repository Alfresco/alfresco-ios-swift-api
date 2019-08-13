//
//  AuthWebPresenter.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import WebKit

class AuthWebPresenter : NSObject {
    var authDelegate: AlfrescoAuthDelegate? = nil
    
    func parse(navigationAction: WKNavigationAction) -> WKNavigationActionPolicy {
        let url = navigationAction.request.url
        if let urlString = url?.absoluteString {
            if urlString.contains("access_token") {
                var alfrescoCredentials = AlfrescoCredential(from: url!)
                let normalizedUrlString = normalizeUrlString(urlString)
                if let normalizedUrl = URL(string: normalizedUrlString) {
                    alfrescoCredentials = AlfrescoCredential(from: normalizedUrl)
                }
                authDelegate?.didReceive(result: .success(alfrescoCredentials))
                return .cancel
            }
        }
        return .allow
    }
    
    func normalizeUrlString(_ urlString: String) -> String {
        let normalizedString = urlString.replacingOccurrences(of: "#", with: "?")
        return normalizedString
    }
}

extension AuthWebPresenter : WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(parse(navigationAction: navigationAction))
    }
}
