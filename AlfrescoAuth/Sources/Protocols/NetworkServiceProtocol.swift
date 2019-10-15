//
//  NetworkServiceProtocol.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 18/09/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AlfrescoCore

public protocol NetworkServiceProtocol {
    var authDelegate: AlfrescoAuthDelegate? { get set }
    var apiClient: APIClientProtocol { get }
}
