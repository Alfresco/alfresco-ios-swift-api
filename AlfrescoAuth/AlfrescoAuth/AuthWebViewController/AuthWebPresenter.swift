//
//  AuthWebPresenter.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 02/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import WebKit
import AlfrescoCore

class AuthWebPresenter: NSObject, NetworkServiceProtocol {
    var authDelegate: AlfrescoAuthDelegate? = nil
    
    func parse(action: WKNavigationAction) -> WKNavigationActionPolicy {
        let url = action.request.url
        if let urlString = url?.absoluteString {
            if urlString.contains("&code=") {
                let normalizedUrlString = urlString.replaceHashTagWithQuestionMark()
                if let normalizedUrl = URL(string: normalizedUrlString) {
                    if let code = normalizedUrl.findAuthorizationCode() {
                        requestToken(with: code) { (result) in
                            DispatchQueue.main.async {
                                self.authDelegate?.didReceive(result: result)
                            }
                        }
                        return .cancel
                    }
                }
                let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Error! Code not found"])
                self.authDelegate?.didReceive(result: Result.failure(error))
                return .cancel
            }
        }
        let error = NSError(domain:"", code:401, userInfo:[ NSLocalizedDescriptionKey: "Error! Code not found"])
        self.authDelegate?.didReceive(result: Result.failure(error))
        return .allow
    }
    
    func requestToken(with code: String, completion: @escaping (Result<AlfrescoCredential, Error>) -> Void) {
        _ = apiClient.send(GetToken(code: code), completion: { (result) in
            completion(result)
        })
        
    }
}

extension AuthWebPresenter: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(parse(action: navigationAction))
    }
}
