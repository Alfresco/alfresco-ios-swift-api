//
//  AlfrescoAuthDelegateStub.swift
//  AlfrescoAuthTests
//
//  Created by Florin Baincescu on 15/10/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation
import AlfrescoAuth
import AlfrescoCore
import XCTest

class AlfrescoAuthDelegateStub: AlfrescoAuthDelegate {
    var expectationForDidReceivedCall: XCTestExpectation!
    var expectationForSuccessInDidReceivedCall: XCTestExpectation!
    var expectationForFailureInDidReceivedCall: XCTestExpectation!
    
    var expectationForSuccessInDidLogoutCall: XCTestExpectation!
    var expectationForFailureInDidLogoutCall: XCTestExpectation!
    
    func didReceive(result: Result<AlfrescoCredential, APIError>, session: AlfrescoAuthSession?) {
        switch result {
        case .success(_):
            expectationForSuccessInDidReceivedCall.fulfill()
        case .failure(_):
            expectationForFailureInDidReceivedCall.fulfill()
        }
        expectationForDidReceivedCall.fulfill()
    }
    
    func didLogOut(result: Result<Int, APIError>) {
        switch result {
        case .success(_):
            expectationForSuccessInDidLogoutCall.fulfill()
        case .failure(_) :
            expectationForFailureInDidLogoutCall.fulfill()
        }
    }
}
