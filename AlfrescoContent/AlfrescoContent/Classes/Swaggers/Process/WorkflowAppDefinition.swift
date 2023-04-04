//
//  WorkflowAppDefinition.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 04/04/23.
//

import Foundation

// MARK: App definition
public class WorkflowAppDefinition: Codable {
    public var size: Int?
    public var total: Int?
    public var start: Int?
    public var data = [WorkflowAppDefinitionDetail]()
}

public class WorkflowAppDefinitionDetail: Codable {
    public var id: Int?
    public var defaultAppId: String?
    public var name: String?
    public var description: String?
    public var modelId: Int?
    public var theme: String?
    public var icon: String?
    public var deploymentId: String?
    public var tenantId: Int?
}
