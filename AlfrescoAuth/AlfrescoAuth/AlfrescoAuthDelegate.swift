//
//  AlfrescoAuthDelegate.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 08/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

public protocol AlfrescoAuthDelegate {
    func didReceive(result: Result<AlfrescoCredential, Error>)
}
