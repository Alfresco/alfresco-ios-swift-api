//
//  WebViewMock.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 15/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import WebKit

class WebViewMock: WKWebView {
    var loadWasCalled = false
    var urlString = ""
    
    override func load(_ request: URLRequest) -> WKNavigation? {
        loadWasCalled = true
        urlString = request.url?.absoluteString ?? ""
        return super.load(request)
    }
}
