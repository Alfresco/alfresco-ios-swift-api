//
// Site.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Site: Codable {

    public enum Visibility: String, Codable { 
        case _private = "PRIVATE"
        case moderated = "MODERATED"
        case _public = "PUBLIC"
    }
    public enum Role: String, Codable { 
        case siteConsumer = "SiteConsumer"
        case siteCollaborator = "SiteCollaborator"
        case siteContributor = "SiteContributor"
        case siteManager = "SiteManager"
    }
    public var _id: String
    public var guid: String
    public var title: String
    public var _description: String?
    public var visibility: Visibility
    public var preset: String?
    public var role: Role?

    public init(_id: String, guid: String, title: String, _description: String?, visibility: Visibility, preset: String?, role: Role?) {
        self._id = _id
        self.guid = guid
        self.title = title
        self._description = _description
        self.visibility = visibility
        self.preset = preset
        self.role = role
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case guid
        case title
        case _description = "description"
        case visibility
        case preset
        case role
    }


}

