//
//  TaskAssigneeUserList.swift
//  AlfrescoContent
//
//  Created by global on 11/09/22.
//

import Foundation

// MARK: - Task Assignee
public class TaskAssigneeUserList: Codable {
    public var size: Int
    public var total: Int
    public var start: Int
    public var data = [TaskAssignee]()
}
