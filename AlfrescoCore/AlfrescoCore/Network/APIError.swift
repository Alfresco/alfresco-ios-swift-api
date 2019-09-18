//
//  APIError.swift
//  AlfrescoCore
//
//  Created by Florin Baincescu on 17/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

let errTryAgain =  "Some error has occurred, try again!"
let errRequestUnavailable = "Request unavailable."

public struct APIError: Error {
    let domain: String
    let userInfo: [String: Any]
    let responseCode: Int
    
    public init(domain: String, userInfo: [String: Any]) {
        self.domain = domain
        self.responseCode = 0
        self.userInfo = userInfo
    }
    
    public init(domain: String, code: Int, userInfo: [String: Any]) {
        self.domain = domain
        self.responseCode = code
        self.userInfo = userInfo
    }
    
    public init(domain: String, message: String) {
        self.domain = domain
        self.responseCode = 0
        self.userInfo = [NSLocalizedDescriptionKey: message]
    }
    
    public init(domain: String, code: Int, message: String) {
        self.domain = domain
        self.responseCode = code
        self.userInfo = [NSLocalizedDescriptionKey: message]
    }
}
