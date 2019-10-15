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
    var successResponse = false
    var expectationForDidRevicedCall: XCTestExpectation!
    var expectationForSuccessInDidRecivedCall: XCTestExpectation!
    var expectationForFailureInDidRecivedCall: XCTestExpectation!
    
    func didReceive(result: Result<AlfrescoCredential, APIError>) {
        switch result {
        case .success(_):
            expectationForSuccessInDidRecivedCall.fulfill()
            successResponse = true
        case .failure(_):
            expectationForFailureInDidRecivedCall.fulfill()
            successResponse = false
        }
        expectationForDidRevicedCall.fulfill()
    }
}
