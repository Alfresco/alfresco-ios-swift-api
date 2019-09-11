//
//  URL+Helpers.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 10/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

extension URL {
    func findAuthorizationCode() -> String? {
        let urlComponents = URLComponents(url: self, resolvingAgainstBaseURL: false)
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
