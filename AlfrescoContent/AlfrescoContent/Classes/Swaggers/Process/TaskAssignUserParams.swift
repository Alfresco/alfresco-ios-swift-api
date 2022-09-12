//
//  TaskAssignUserParams.swift
//  AlfrescoContent
//
//  Created by global on 11/09/22.
//

import Foundation

public struct TaskAssignUserParams: Codable {
    public var filter: String?
    public var email: String?
    
    public init(filter: String?,
                email: String?) {
        self.filter = filter
        self.email = email
    }
}
