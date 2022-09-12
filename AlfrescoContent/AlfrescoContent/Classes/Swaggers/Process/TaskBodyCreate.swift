//
//  TaskBodyCreate.swift
//  AlfrescoContent
//
//  Created by global on 11/09/22.
//

import Foundation

public struct TaskBodyCreate: Codable {
    public var name: String?
    public var priority: String?
    public var dueDate: String?
    public var description: String?
    
    public init(name: String?,
                priority: String?,
                dueDate: String?,
                description: String?) {
        self.name = name
        self.priority = priority
        self.dueDate = dueDate
        self.description = description
    }
}
