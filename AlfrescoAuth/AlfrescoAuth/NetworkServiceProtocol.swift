//
//  BasicProtocol.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 10/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AlfrescoCore

protocol NetworkServiceProtocol {
    var apiClient: APIClient { get }
}

extension NetworkServiceProtocol {
    var apiClient: APIClient {
        return APIClient(with: kBaseURLString)
    }
}
