//
//  LogoutRequest.swift
//  AlfrescoAuth
//
//  Created by Emanuel Lupu on 06/12/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AlfrescoCore

struct LogoutRequest: APIRequest {
    typealias Response = StatusCodeResponse

    let serviceDocumentInstanceURL: String
    
    var path: String {
        return String(format:"%@%@", serviceDocumentInstanceURL, kLogoutEndPoint)
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var headers: [String : ContentType] {
        return [:]
    }
    
    var parameters: [String : String] {
        return [:]
    }
    
    init(serviceDocumentInstanceURL: String) {
        self.serviceDocumentInstanceURL = serviceDocumentInstanceURL
    }
}
