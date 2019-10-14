//
//  TestData.swift
//  AlfrescoCoreTests
//
//  Created by Silviu Odobescu on 27/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
@testable import AlfrescoCore

//struct TestData {
//    static let baseURLString = "http://alfresco-identity-service.mobile.dev.alfresco.me"
//    static let path = "/auth"
//    static let headerFieldsContentType = "Content-Type"
//    static let headerFieldsContentTypeValue = "application/x-www-form-urlencoded"
//    static let params = ["grant_type": "password"]
//    static let paramsPercentEscaped = "grant_type=password"
//    static let getURLWithParams = "http://alfresco-identity-service.mobile.dev.alfresco.me/auth?grant_type=password"
//}

struct TestData {
    static let baseURL = "http://domain.extension"
    static let invalidBaseURL = " "
    static let testAPIRequestPath = "/path"
    static let invalidAPIRequestPath = " "
    static let clientID = "id"
    static let clientSecret = "secret"
    static var response = ["name" : "test"]
    static var invalidResponse = "response"
}

struct TestAPIRequest: APIRequest {
    typealias Response = [String : String]
    
    var path: String {
        return TestData.testAPIRequestPath
    }
    
    var method: HttpMethod {
        return .get
    }
    
    var headers: [String : ContentType] {
        return ["Content-Type": .urlencoded]
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
    
    var headers: [String : ContentType] {
        return ["Content-Type": .urlencoded]
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
    
    var headers: [String : ContentType] {
        return ["Content-Type": .urlencoded]
    }
    
    var parameters: [String : String] {
        return ["client_id": TestData.clientID,
                "client_secret": TestData.clientSecret]
    }
}


