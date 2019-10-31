//
//  APIResponse.swift
//  AlfrescoCore
//
//  Created by Florin Baincescu on 10/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public protocol APIResponse: Decodable { }

public struct StatusCodeResponse: APIResponse {
    let responseCode: Int
}
