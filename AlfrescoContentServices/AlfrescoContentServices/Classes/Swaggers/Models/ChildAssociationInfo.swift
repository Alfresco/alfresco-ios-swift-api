//
// ChildAssociationInfo.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ChildAssociationInfo: Codable {

    public var assocType: String
    public var isPrimary: Bool

    public init(assocType: String, isPrimary: Bool) {
        self.assocType = assocType
        self.isPrimary = isPrimary
    }


}

