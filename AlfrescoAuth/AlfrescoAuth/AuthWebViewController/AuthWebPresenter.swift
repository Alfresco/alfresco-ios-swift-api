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

class AuthWebPresenter: NSObject {
    var authDelegate: AlfrescoAuthDelegate? = nil
    
    func parse(action: WKNavigationAction) -> WKNavigationActionPolicy {
        let url = action.request.url
        if let urlString = url?.absoluteString {
            if urlString.contains("&code=") {
                let normalizedUrlString = urlString.replaceHashTagWithQuestionMark()
                if let normalizedUrl = URL(string: normalizedUrlString) {
                    if let code = getCode(from: normalizedUrl) {
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
    
    func requestToken(with code: String, completionHandler: @escaping (Result<AlfrescoCredential, Error>) -> Void) {
        let core = AlfrescoCore()
        let builder = core.requestBuilder(baseURLString: baseURLString)
        let path = tokenEndpoint
        let headers = ["Content-Type": ContentType.urlencoded]
        let parameters: [String: String] = ["grant_type": "authorization_code",
                                            "client_id": clientID,
                                            "client_secret": clientSecret,
                                            "redirect_uri": "",
                                            "code": code]
        let request = builder.request(method: .post, path: path, headerFields: headers, parameters: parameters)
        _ = builder.start(request: request, completionHandler: { (result) in
            switch result {
            case .success(let model):
                let credential = AlfrescoCredential.init(with: model)
                completionHandler(Result.success(credential))
                break
            case .failure(let error):
                completionHandler(Result.failure(error))
                break
            }
        })
    }
    
    func getCode(from url: URL) -> String? {
        let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
        if let queryItems = urlComponents?.queryItems {
            for item in queryItems {
                switch item.name {
                case "code":
                    return item.value!
                default: break
                }
            }
        }
        return nil
    }
}

extension AuthWebPresenter: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(parse(action: navigationAction))
    }
}
