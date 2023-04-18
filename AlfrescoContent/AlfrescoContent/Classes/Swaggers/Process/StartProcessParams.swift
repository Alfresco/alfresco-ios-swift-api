//
//  StartProcessParams.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 17/04/23.
//

import Foundation

// MARK: - Task Priority
public enum TaskPriority: String, Codable {
    case low = "Low"
    case medium = "Medium"
    case high = "High"
}

// MARK: - Start process params
public struct StartProcessParams: Codable {
    public var message: String?
    public var dueDate: String?
    public var attachmentIds: String?
    public var priority: TaskPriority?
    public var reviewer: ReviewerParams?
    public var sendemailnotifications: Bool?

    public init(message: String?,
                dueDate: String?,
                attachmentIds: String?,
                priority: TaskPriority?,
                reviewer: ReviewerParams?,
                sendemailnotifications: Bool?) {
        self.message = message
        self.dueDate = dueDate
        self.attachmentIds = attachmentIds
        self.priority = priority
        self.reviewer = reviewer
        self.sendemailnotifications = sendemailnotifications
    }
}

// MARK: -
public struct StartProcessBodyCreate: Codable {
    public var name: String?
    public var processDefinitionId: String?
    public var values: StartProcessValueParams?
    
    public init(name: String?,
                processDefinitionId: String?,
                params: StartProcessParams?) {
        self.name = name
        self.processDefinitionId = processDefinitionId
        self.values = createValueParams(params: params)
    }
    
    func createValueParams(params: StartProcessParams?) -> StartProcessValueParams {
        
        let priority = StartProcessPriority(id: params?.priority?.rawValue, name: params?.priority?.rawValue)
        let reviewer = ReviewerParams(email: params?.reviewer?.email,
                                      firstName: params?.reviewer?.firstName,
                                      lastName: params?.reviewer?.lastName,
                                      id: params?.reviewer?.id)
        return StartProcessValueParams(message: params?.message,
                                            due: params?.dueDate,
                                            items: params?.attachmentIds,
                                            priority: priority,
                                            reviewer: reviewer,
                                            sendemailnotifications: params?.sendemailnotifications)
        
    }
}

// MARK: - Value params
public struct StartProcessValueParams: Codable {
    public var message: String?
    public var due: String?
    public var items: String?
    public var priority: StartProcessPriority?
    public var reviewer: ReviewerParams?
    public var sendemailnotifications: Bool?

    public init(message: String?,
                due: String?,
                items: String?,
                priority: StartProcessPriority?,
                reviewer: ReviewerParams?,
                sendemailnotifications: Bool?) {
        self.message = message
        self.due = due
        self.items = items
        self.priority = priority
        self.reviewer = reviewer
        self.sendemailnotifications = sendemailnotifications
    }
}

// MARK: - Priority params
public struct StartProcessPriority: Codable {
    public var id: String?
    public var name: String?

    public init(id: String?,
                name: String?) {
        self.id = id
        self.name = name
    }
}

// MARK: - Reviewer params
public struct ReviewerParams: Codable {
    public var email: String?
    public var firstName: String?
    public var lastName: String?
    public var id: Int?
    public var groupName: String?
    public var externalId: String?
    public var parentGroupId: String?

    public init(email: String?,
                firstName: String?,
                lastName: String?,
                id: Int?,
                groupName: String? = nil,
                externalId: String? = nil,
                parentGroupId: String? = nil) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
        if let groupName = groupName, !groupName.isEmpty {
            self.groupName = groupName
            self.externalId = externalId
            self.parentGroupId = parentGroupId
        }
    }
}
