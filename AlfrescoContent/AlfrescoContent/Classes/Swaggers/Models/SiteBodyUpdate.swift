//
// SiteBodyUpdate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct SiteBodyUpdate: Codable {

    public enum Visibility: String, Codable { 
        case _private = "PRIVATE"
        case moderated = "MODERATED"
        case _public = "PUBLIC"
    }
    public var title: String?
    public var _description: String?
    public var visibility: Visibility?

    public init(title: String?, _description: String?, visibility: Visibility?) {
        self.title = title
        self._description = _description
        self.visibility = visibility
    }

    public enum CodingKeys: String, CodingKey { 
        case title
        case _description = "description"
        case visibility
    }


}

