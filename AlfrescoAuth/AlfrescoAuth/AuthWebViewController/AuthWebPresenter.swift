//
//  AuthWebPresenter.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import WebKit

class AuthWebPresenter: NSObject {
    var authDelegate: AlfrescoAuthDelegate? = nil
    
    func parse(action: WKNavigationAction) -> WKNavigationActionPolicy {
        let url = action.request.url
        if let urlString = url?.absoluteString {
            if urlString.contains("access_token") {
                var alfrescoCredentials = AlfrescoCredential(with: url!)
                let normalizedUrlString = urlString.replaceHashTagWithQuestionMark()
                if let normalizedUrl = URL(string: normalizedUrlString) {
                    alfrescoCredentials = AlfrescoCredential(with: normalizedUrl)
                }
                authDelegate?.didReceive(result: .success(alfrescoCredentials))
                return .cancel
            }
        }
        return .allow
    }
}

extension AuthWebPresenter: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(parse(action: navigationAction))
    }
}
