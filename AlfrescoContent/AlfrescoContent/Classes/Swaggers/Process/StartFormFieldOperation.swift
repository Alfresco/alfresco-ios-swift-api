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
        
        let fieldsArray = data?.fields ?? []
        for fieldObject in fieldsArray {
            let fields = fieldObject.fields ?? [:]
            let allKeys = fields.keys.sorted()
            for key in allKeys {
                let array = fields[key] ?? []
                for elements in array {
                    processedFields.append(elements)
                }
            }
        }
        return processedFields
    }
}
