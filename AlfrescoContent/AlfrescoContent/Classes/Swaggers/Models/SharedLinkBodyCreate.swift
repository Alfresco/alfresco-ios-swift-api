//
// SharedLinkBodyCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct SharedLinkBodyCreate: Codable {

    public var nodeId: String
    public var expiresAt: Date?

    public init(nodeId: String, expiresAt: Date?) {
        self.nodeId = nodeId
        self.expiresAt = expiresAt
    }


}

