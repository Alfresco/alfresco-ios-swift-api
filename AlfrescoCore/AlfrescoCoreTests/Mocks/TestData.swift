//
//  TestData.swift
//  AlfrescoCoreTests
//
//  Created by Silviu Odobescu on 27/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
@testable import AlfrescoCore

struct TestData {
    static let baseURL = "http://domain.extension"
    static let invalidBaseURL = " "
    static let testAPIRequestPath = "/path"
    static let invalidAPIRequestPath = " "
    static let clientID = "id"
    static let clientSecret = "secret"
    static var response = ["name" : "test"]
    static var invalidResponse = "response"
    static let errorDomain = "domain"
    static let errorCode = 1000
    static let errorMessage = "message"
    static let errorObj = APIError(domain: "test", code: 0, message: "error message")
}
