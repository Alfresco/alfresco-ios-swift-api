//
//  GetProcessServiceDocument.swift
//  AlfrescoAuth
//
//  Created by Emanuel Lupu on 30/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AlfrescoCore


struct GetServiceDocumentInstance: APIRequest {
    typealias Response = StatusCodeResponse
    
    let serviceDocumentInstanceURL: String
    
    var path: String {
        return serviceDocumentInstanceURL
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
