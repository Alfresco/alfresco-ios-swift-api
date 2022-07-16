//
//  TaskFilters.swift
//  AlfrescoContent
//
//  Created by global on 16/07/22.
//

import UIKit

// MARK: Task Filters List Model
public class TaskFiltersList: Codable {
    public var size: Int?
    public var total: Int?
    public var start: Int?
    public var data = [TaskFilters]()
}

// MARK: Tasks
public class TaskFilters: Codable {
    public var id: Int?
    public var name: String?
    public var recent: Bool?
    public var icon: String?
    public var filter: TaskFilterQuery?
}

// MARK: Task Assignee
public class TaskFilterQuery: Codable {
    public var sort: String?
    public var name: String?
    public var assignment: String?
}
