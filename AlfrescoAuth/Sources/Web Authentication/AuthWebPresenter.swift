//
// Copyright (C) 2005-2020 Alfresco Software Limited.
//
// This file is part of the Alfresco Content Mobile iOS App.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import WebKit
import AlfrescoCore

class AuthWebPresenter: NSObject, NetworkServiceProtocol {
    var authDelegate: AlfrescoAuthDelegate? = nil
    var apiClient: APIClientProtocol
    var configuration: AuthConfiguration
    
    init(configuration: AuthConfiguration) {
        self.configuration = configuration
        self.apiClient = APIClient(with: configuration.baseUrl)
    }
    
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
                self.authDelegate?.didReceive(result: .failure(APIError(domain: moduleName, code: ModuleErrorType.errorAuthCodeNotFound.code, message: errorAuthCodeNotFound)))
                return .cancel
            }
        }
        return .allow
    }
    
    func requestToken(with code: String, completion: @escaping (Result<AlfrescoCredential, APIError>) -> Void) {
        _ = apiClient.send(GetAlfrescoCredential(code: code, configuration: configuration), completion: { (result) in
            completion(result)
        })
        
    }
}

extension AuthWebPresenter: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        decisionHandler(parse(action: navigationAction))
    }
}
