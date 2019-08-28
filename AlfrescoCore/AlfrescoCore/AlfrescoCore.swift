//
//  AlfrescoCore.swift
//  AlfrescoCore
//
//  Created by Silviu Odobescu on 26/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public struct AlfrescoCore {
    public init () { }
    
    public func requestBuilder(baseURLString: String) -> RequestBuilderProtocol {
        return NetworkRequestBuilder(baseURL: URL(string: baseURLString))
    }
}
