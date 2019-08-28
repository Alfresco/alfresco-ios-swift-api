//
//  TestData.swift
//  AlfrescoCoreTests
//
//  Created by Silviu Odobescu on 27/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

struct TestData {
    static let baseURLString = "http://alfresco-identity-service.mobile.dev.alfresco.me"
    static let path = "/auth"
    static let headerFieldsContentType = "Content-Type"
    static let headerFieldsContentTypeValue = "application/x-www-form-urlencoded"
    static let params = ["grant_type": "password"]
    static let paramsPercentEscaped = "grant_type=password"
    static let getURLWithParams = "http://alfresco-identity-service.mobile.dev.alfresco.me/auth?grant_type=password"
}
