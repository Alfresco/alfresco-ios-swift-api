//
//  StartProcessParams.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 17/04/23.
//

import Foundation


// MARK: - Start process params
public struct StartProcessParams: Codable {
    public var message: String?
    public var dueDate: String?
    public var attachmentIds: String?
    public var priority: String?
    public var reviewer: ReviewerParams?
    public var reviewgroups: GroupReviewerParams?
    public var sendemailnotifications: Bool?

    public init(message: String?,
                dueDate: String?,
                attachmentIds: String?,
                priority: String?,
                reviewer: ReviewerParams?,
                reviewgroups: GroupReviewerParams?,
                sendemailnotifications: Bool?) {
        self.message = message
        self.dueDate = dueDate
        self.attachmentIds = attachmentIds
        self.priority = priority
        self.reviewer = reviewer
        self.reviewgroups = reviewgroups
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
        
        let priority = StartProcessPriority(id: params?.priority,
                                            name: params?.priority)
        return StartProcessValueParams(message: params?.message,
                                            due: params?.dueDate,
                                            items: params?.attachmentIds,
                                            priority: priority,
                                       reviewer: params?.reviewer,
                                       reviewgroups: params?.reviewgroups,
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
    public var reviewgroups: GroupReviewerParams?
    public var sendemailnotifications: Bool?

    public init(message: String?,
                due: String?,
                items: String?,
                priority: StartProcessPriority?,
                reviewer: ReviewerParams?,
                reviewgroups: GroupReviewerParams?,
                sendemailnotifications: Bool?) {
        self.message = message
        self.due = due
        self.items = items
        self.priority = priority
        self.reviewer = reviewer
        self.reviewgroups = reviewgroups
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

    public init(email: String?,
                firstName: String?,
                lastName: String?,
                id: Int?) {
        self.email = email
        self.firstName = firstName
        self.lastName = lastName
        self.id = id
    }
}

// MARK: - Reviewer params
public struct GroupReviewerParams: Codable {
    public var id: Int?
    public var name: String?
    public var externalId: String?
    public var status: String?
    public var parentGroupId: String?
    public var groups: String?

    public init(id: Int?,
                name: String?,
                externalId: String?,
                status: String?,
                parentGroupId: String?,
                groups: String?) {
        self.id = id
        self.name = name
        self.externalId = externalId
        self.status = status
        self.parentGroupId = parentGroupId
        self.groups = groups
    }
}

// MARK: - Start WorkFlow
public struct StartWorkFlowBodyCreate: Codable {
    public var name: String?
    public var processDefinitionId: String?
    public var values: CodableDictionary?
    
    public init(name: String?,
                processDefinitionId: String?,
                params: [String: AnyEncodable]) {
        self.name = name
        self.processDefinitionId = processDefinitionId
        self.values = CodableDictionary(params)
    }
}

public struct CodableDictionary: Codable {
    private var wrappedDictionary: [String: AnyEncodable]

    public init(_ dictionary: [String: AnyEncodable]) {
        self.wrappedDictionary = dictionary
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedDictionary = try container.decode([String: AnyEncodable].self)
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encode(wrappedDictionary)
    }
}

public struct AnyEncodable: Codable {
    private let encodable: Encodable

    public init(_ encodable: Encodable) {
        self.encodable = encodable
    }

    public func encode(to encoder: Encoder) throws {
        try encodable.encode(to: encoder)
    }

    public init(from decoder: Decoder) throws {
        fatalError("Decoding AnyEncodable directly is not supported. Decode the underlying type instead.")
    }
}
