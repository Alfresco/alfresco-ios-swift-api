//
//  AuthBasicViewProtocol.swift
//  AlfrescoAuth
//
//  Created by Florin Baincescu on 26/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import UIKit

enum InputType {
    case username
    case password
}

protocol AuthBasicViewProtocol {
    func display(errorMessage: String, type: InputType)
    func display(alertError: UIAlertController)
    func success(credential: AlfrescoCredential)
}
