//
// AssociationBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct AssociationBody: Codable {

    public var targetId: String
    public var assocType: String

    public init(targetId: String, assocType: String) {
        self.targetId = targetId
        self.assocType = assocType
    }


}

