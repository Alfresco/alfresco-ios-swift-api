//
//  MockedObjects.swift
//  AlfrescoCoreTests
//
//  Created by Emanuel Lupu on 11/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
@testable import AlfrescoCore

struct TestAPIRequest: APIRequest {
    typealias Response = [String : String]
    
    var path: String {
        return TestData.testAPIRequestPath
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var headers: [String : String] {
        return ["Content-Type": ContentType.urlencoded.rawValue]
    }
    
    var parameters: [String : String] {
        return ["client_id": TestData.clientID,
                "client_secret": TestData.clientSecret]
    }
}

struct TestPOSTAPIRequest: APIRequest {
    typealias Response = String
    
    var path: String {
        return TestData.testAPIRequestPath
    }
    
    var method: HttpMethod {
        return .post
        
    }
    
    var headers: [String : String] {
        return ["Content-Type": ContentType.urlencoded.rawValue]
    }
    
    var parameters: [String : String] {
        return ["client_id": TestData.clientID,
                "client_secret": TestData.clientSecret]
    }
}

struct TestAPIRequestWithInvalidPath: APIRequest {
    typealias Response = String
    
    var path: String {
        return TestData.invalidAPIRequestPath
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var headers: [String : String] {
        return ["Content-Type": ContentType.urlencoded.rawValue]
    }
    
    var parameters: [String : String] {
        return ["client_id": TestData.clientID,
                "client_secret": TestData.clientSecret]
    }
}
