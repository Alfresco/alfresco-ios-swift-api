//
// SiteMembershipBodyCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct SiteMembershipBodyCreate: Codable {

    public enum Role: String, Codable { 
        case siteConsumer = "SiteConsumer"
        case siteCollaborator = "SiteCollaborator"
        case siteContributor = "SiteContributor"
        case siteManager = "SiteManager"
    }
    public var role: Role
    public var _id: String

    public init(role: Role, _id: String) {
        self.role = role
        self._id = _id
    }

    public enum CodingKeys: String, CodingKey { 
        case role
        case _id = "id"
    }


}

