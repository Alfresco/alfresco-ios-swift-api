//
//  TaskListParams.swift
//  AlfrescoContent
//
//  Created by global on 10/07/22.
//

import UIKit

public struct TaskListParams: Codable {

    public var appDefinitionId: String?
    public var assignment: String?
    public var dueAfter: String?
    public var dueBefore: String?
    public var includeProcessInstance: Bool = true
    public var includeProcessVariables: Bool = true
    public var includeTaskLocalVariables: Bool = true
    public var page: Int = 0
    public var processDefinitionId: String?
    public var processInstanceId: String?
    public var size: Int = 25
    public var sort: String?
    public var start: Int = 0
    public var state: String?
    public var taskId: String?
    public var text: String?
    
    public init(appDefinitionId: String? = nil,
                assignment: String? = nil,
                dueAfter: String? = nil,
                dueBefore: String? = nil,
                includeProcessInstance: Bool = true,
                includeProcessVariables: Bool = true,
                includeTaskLocalVariables: Bool = true,
                page: Int,
                processDefinitionId: String? = nil,
                processInstanceId: String? = nil,
                size: Int = 25,
                sort: String? = nil,
                start: Int = 0,
                state: String? = nil,
                taskId: String? = nil,
                text: String? = nil) {
        
        self.appDefinitionId = appDefinitionId
        self.assignment = assignment
        self.dueAfter = dueAfter
        self.dueBefore = dueBefore
        self.includeProcessInstance = includeProcessInstance
        self.includeProcessVariables = includeProcessVariables
        self.includeTaskLocalVariables = includeTaskLocalVariables
        self.page = page
        self.processDefinitionId = processDefinitionId
        self.processInstanceId = processInstanceId
        self.size = size
        self.sort = sort
        self.start = start
        self.state = state
        self.taskId = taskId
        self.text = text
    }
}


