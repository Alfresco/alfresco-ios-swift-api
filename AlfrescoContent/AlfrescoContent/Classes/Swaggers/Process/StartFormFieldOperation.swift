//
//  StartFormFieldOperation.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 01/05/23.
//

import Foundation

class StartFormFieldOperation: NSObject {

    static func processFormFields(for data: StartFormFields?) -> [Field] {
        var processedFields: [Field] = []
        
        let fields = data?.fields[0].fields ?? [:]
        let allKeys = fields.keys
        for key in allKeys {
            let array = fields[key] ?? []
            for elements in array {
                processedFields.append(elements)
            }
        }
        return processedFields
    }
}
