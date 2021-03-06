//
// ActionBodyExec.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ActionBodyExec: Codable {

    public var actionDefinitionId: String
    /** The entity upon which to execute the action, typically a node ID or similar. */
    public var targetId: String?
    public var params: JSONValue?

    public init(actionDefinitionId: String, targetId: String?, params: JSONValue?) {
        self.actionDefinitionId = actionDefinitionId
        self.targetId = targetId
        self.params = params
    }


}

