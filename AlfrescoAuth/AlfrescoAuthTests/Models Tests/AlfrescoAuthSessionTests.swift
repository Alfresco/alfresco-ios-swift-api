//
//  AlfrescoAuthSessionTests.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 15/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import XCTest
import AppAuth
@testable import AlfrescoAuth

class AlfrescoAuthSessionTests: XCTestCase {
    var sut: AlfrescoAuthSession!
    
    override func setUp() {
        super.setUp()
        sut = AlfrescoAuthSession()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testSutIsNotNil() {
        XCTAssertNotNil(sut)
    }
    
    func testResumeExternalUserAgentFlowTrue() {
        let authorizationFlowStub = OIDExternalUserAgentSessionStub()
        authorizationFlowStub.successResponse = true
        sut.authorizationFlow = authorizationFlowStub
        
        let resumeAgentResponse = sut.resumeExternalUserAgentFlow(with: URL(string: TestData.urlStringToLoadGood)!)
        XCTAssertTrue(resumeAgentResponse)
    }
    
    func testResumeExternalUserAgentFlowFalse() {
        let authorizationFlowStub = OIDExternalUserAgentSessionStub()
        authorizationFlowStub.successResponse = false
        sut.authorizationFlow = authorizationFlowStub
        
        let resumeAgentResponse = sut.resumeExternalUserAgentFlow(with: URL(string: TestData.urlStringToLoadGood)!)
        XCTAssertFalse(resumeAgentResponse)
    }
    
    
}
