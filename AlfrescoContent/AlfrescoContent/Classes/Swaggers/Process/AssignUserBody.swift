//
//  AssignUserBody.swift
//  AlfrescoContent
//
//  Created by global on 11/09/22.
//

import Foundation

public struct AssignUserBody: Codable {
    public var assignee: String
    
    public init(assignee: String) {
        self.assignee = assignee
    }
}
