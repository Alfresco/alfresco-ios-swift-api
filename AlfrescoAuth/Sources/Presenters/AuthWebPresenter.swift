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
    var apiClient = APIClient(with: kBaseURLString)
    
    func parse(action: WKNavigationAction) -> WKNavigationActionPolicy {
        let url = action.request.url
        if let urlString = url?.absoluteString {
            if urlString.contains("&code=") {
                let normalizedUrlString = urlString.replaceHashTagWithQuestionMark()
                if let normalizedUrl = URL(string: normalizedUrlString) {
                    if let code = normalizedUrl.findAuthorizationCode() {
                        requestToken(with: code) { [weak self] (result) in
                            guard let sSelf = self else { return }
                            DispatchQueue.main.async {
                                sSelf.authDelegate?.didReceive(result: result)
                            }
                        }
                        return .cancel
                    }
                }
                self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, message: "Couldn't find AUTHORIZATION CODE!")))
                return .cancel
            }
        }
        return .allow
    }
    
    func requestToken(with code: String, completion: @escaping (Result<AlfrescoCredential, Error>) -> Void) {
        _ = apiClient.send(GetAlfrescoCredential(code: code), completion: { (result) in
            completion(result)
        })
        
    }
}

extension AuthWebPresenter: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(parse(action: navigationAction))
    }
}