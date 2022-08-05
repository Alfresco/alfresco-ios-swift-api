//
//  TaskComment.swift
//  AlfrescoContent
//
//  Created by global on 05/08/22.
//

import Foundation

// MARK: - Task Comments
public class Comments: Codable {
    public var size: Int
    public var total: Int
    public var start: Int
    public var data = [TaskComment]()
}

// MARK: - Comment
public class TaskComment: Codable {
    public var created: Date?
    public var createdBy: TaskAssignee?
    public var id: Int?
    public var message: String?
}
