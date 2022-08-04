//
//  Task.swift
//  AlfrescoContent
//
//  Created by global on 04/07/22.
//

import Foundation

// MARK: Task List Model
public class TaskList: Codable {
    public var size: Int
    public var total: Int
    public var start: Int
    public var data = [Task]()
}

// MARK: Tasks
public class Task: Codable {
    public var id: String?
    public var name: String?
    public var description: String?
    public var category: String?
    public var assignee: TaskAssignee?
    public var created: Date?
    public var dueDate: Date?
    public var endDate: Date?
    public var duration: Int?
    public var priority: Int?
    public var parentTaskId: Int?
    public var parentTaskName: String?
    public var processInstanceId: String?
    public var processInstanceName: String?
    public var processDefinitionId: String?
    public var processDefinitionName: String?
    public var processDefinitionDescription: String?
    public var processDefinitionKey: String?
    public var processDefinitionCategory: String?
    public var processDefinitionVersion: Int?
    public var processDefinitionDeploymentId: String?
    public var formKey: String?
    public var processInstanceStartUserId: String?
    public var initiatorCanCompleteTask: Bool?
    public var deactivateUserTaskReassignment: Bool?
    public var adhocTaskCanBeReassigned: Bool?
    public var taskDefinitionKey: String?
    public var executionId: String?
    public var memberOfCandidateGroup: Bool?
    public var memberOfCandidateUsers: Bool?
    public var managerOfCandidateGroup: Bool?
}

// MARK: Task Assignee
public class TaskAssignee: Codable {
    public var id: Int
    public var firstName: String?
    public var lastName: String?
    public var email: String?
}
