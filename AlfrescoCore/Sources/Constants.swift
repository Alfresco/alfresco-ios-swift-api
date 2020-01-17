//
//  Constants.swift
//  AlfrescoCore
//
//  Created by Florin Baincescu on 16/01/2020.
//  Copyright © 2020 Alfresco. All rights reserved.
//

import Foundation

// Error messages

let errorDataTaskResultNil = "DataTaskResult has nil parameters."
let errorResponseConvertToDictionary = "Data error response failed to convert into Dictionary."
let errorRequestUnavailable = "URLRequest has failed to be created."



// Module Error Type

public enum ModuleErrorType: Int {
    case errorDataTaskResultNil = 1000
    case errorResponseConvertToDictionary = 1001
    case errorRequestUnavailable = 1002
    
    public var code: Int {
        return rawValue
    }
}
