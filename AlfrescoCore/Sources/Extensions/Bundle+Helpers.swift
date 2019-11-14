//
//  Bundle+Helpers.swift
//  AlfrescoCoreTests
//
//  Created by Emanuel Lupu on 11/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

extension Bundle {
    public var bundleName: String? {
        return object(forInfoDictionaryKey: "CFBundleName") as? String
    }
}
