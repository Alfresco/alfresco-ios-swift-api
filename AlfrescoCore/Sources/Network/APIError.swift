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
    var userInfo: [String: Any]
    let responseCode: Int
    
    public init(domain: String, code: Int = 0, message: String = "", userInfo: [String: Any] = ["": ""], error: Error? = nil ) {
        self.domain = domain
        self.responseCode = code
        self.userInfo = userInfo
        if message != "" {
            self.userInfo = [NSLocalizedDescriptionKey: message]
        }
        if let error = error {
            self.userInfo = [NSLocalizedDescriptionKey: error.localizedDescription]
            if message != "" {
                self.userInfo = [NSLocalizedFailureErrorKey: message]
            }
        }
    }
}
