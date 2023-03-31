//
//  ProcessDefinition.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 31/03/23.
//

import Foundation

// MARK: Process definition
public class ProcessDefinition: Codable {
    public var size: Int?
    public var total: Int?
    public var start: Int?
    public var data = [ProcessDefinitionDetail]()
}

public class ProcessDefinitionDetail: Codable {
    public var id: String?
    public var name: String?
    public var description: String?
    public var key: String?
    public var category: String?
    public var version: Int?
    public var deploymentId: String?
    public var tenantId: String?
    public var hasStartForm: Bool?
}
