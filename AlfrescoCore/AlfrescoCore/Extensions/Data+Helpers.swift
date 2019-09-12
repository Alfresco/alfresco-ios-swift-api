//
//  Data+Helpers.swift
//  AlfrescoCore
//
//  Created by Florin Baincescu on 04/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

extension Data {
    func convertToDictionary() -> [String: Any]? {
        do {
            return try JSONSerialization.jsonObject(with: self, options: []) as? [String: Any]
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
