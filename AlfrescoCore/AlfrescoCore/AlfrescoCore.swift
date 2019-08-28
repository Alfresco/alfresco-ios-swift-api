//
//  AlfrescoCore.swift
//  AlfrescoCore
//
//  Created by Silviu Odobescu on 26/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

struct AlfrescoCore {
    func requestBuilder(baseURLString: String) -> RequestBuilderProtocol {
        return NetworkRequestBuilder(baseURL: URL(string: baseURLString))
    }
}
