//
//  WKNavigationActionStub.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 15/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import WebKit

class WKNavigationActionStub: WKNavigationAction {
    var sendCodeUrl: Bool = true
    override var request: URLRequest {
        if sendCodeUrl {
            return URLRequest(url: URL(string: TestData.urlStringToLoadGood)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 0)
        } else {
            return URLRequest(url: URL(string: TestData.urlStringWithoutCode)!, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 0)
        }
    }
}
