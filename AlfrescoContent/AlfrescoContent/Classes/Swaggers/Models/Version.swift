//
// Version.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Version: Codable {

    public var _id: String
    public var versionComment: String?
    /** The name must not contain spaces or the following special characters: * \&quot; &lt; &gt; \\ / ? : and |. The character . must not be used at the end of the name.  */
    public var name: String
    public var nodeType: String
    public var isFolder: Bool
    public var isFile: Bool
    public var modifiedAt: Date
    public var modifiedByUser: UserInfo
    public var content: ContentInfo?
    public var aspectNames: [String]?
    public var properties: JSONValue?

    public init(_id: String, versionComment: String?, name: String, nodeType: String, isFolder: Bool, isFile: Bool, modifiedAt: Date, modifiedByUser: UserInfo, content: ContentInfo?, aspectNames: [String]?, properties: JSONValue?) {
        self._id = _id
        self.versionComment = versionComment
        self.name = name
        self.nodeType = nodeType
        self.isFolder = isFolder
        self.isFile = isFile
        self.modifiedAt = modifiedAt
        self.modifiedByUser = modifiedByUser
        self.content = content
        self.aspectNames = aspectNames
        self.properties = properties
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case versionComment
        case name
        case nodeType
        case isFolder
        case isFile
        case modifiedAt
        case modifiedByUser
        case content
        case aspectNames
        case properties
    }


}

