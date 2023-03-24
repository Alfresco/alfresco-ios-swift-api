//
//  ProcessList.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 24/03/23.
//

import Foundation

// MARK: Task Process List Model
public class ProcessList: Codable {
    public var size: Int?
    public var total: Int?
    public var start: Int?
    public var data = [Process]()
}

// MARK: Process
public class Process: Codable {
    public var id: String?
    public var name: String?
    public var businessKey: String?
    public var processDefinitionId: String?
    public var tenantId: String?
    public var started: Date?
    public var ended: Date?
    public var startedBy: ProcessUser?
    public var processDefinitionName: String?
    public var processDefinitionDescription: String?
    public var processDefinitionKey: String?
    public var processDefinitionCategory: String?
    public var processDefinitionVersion: Int?
    public var processDefinitionDeploymentId: String?
    public var graphicalNotationDefined: Bool?
    public var startFormDefined: Bool?
    public var suspended: Bool?
}

// MARK: Process User
public class ProcessUser: Codable {
    public var sort: String?
    public var name: String?
    public var assignment: String?
}
