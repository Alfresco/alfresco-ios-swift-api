//
//  Dictionary+Helpers.swift
//  AlfrescoCore
//
//  Created by Silviu Odobescu on 26/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

extension Dictionary {
    func percentEscaped() -> String {
        return map { (key, value) in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryValueAllowed) ?? ""
            return "\(escapedKey)=\(escapedValue)"
        }
        .joined(separator: "&")
    }
}
