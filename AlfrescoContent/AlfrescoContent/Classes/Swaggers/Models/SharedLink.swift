//
// SharedLink.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct SharedLink: Codable {

    public var _id: String?
    public var expiresAt: Date?
    public var nodeId: String?
    /** The name must not contain spaces or the following special characters: * \&quot; &lt; &gt; \\ / ? : and |. The character . must not be used at the end of the name.  */
    public var name: String?
    public var title: String?
    public var _description: String?
    public var modifiedAt: Date?
    public var modifiedByUser: UserInfo?
    public var sharedByUser: UserInfo?
    public var content: ContentInfo?
    /** The allowable operations for the Quickshare link itself. See allowableOperationsOnTarget for the allowable operations pertaining to the linked content node.  */
    public var allowableOperations: [String]?
    /** The allowable operations for the content node being shared.  */
    public var allowableOperationsOnTarget: [String]?
    public var isFavorite: Bool?
    /** A subset of the target node&#39;s properties, system properties and properties already available in the SharedLink are excluded.  */
    public var properties: JSONValue?
    public var aspectNames: [String]?
    public var path: PathInfo?

    public init(_id: String?, expiresAt: Date?, nodeId: String?, name: String?, title: String?, _description: String?, modifiedAt: Date?, modifiedByUser: UserInfo?, sharedByUser: UserInfo?, content: ContentInfo?, allowableOperations: [String]?, allowableOperationsOnTarget: [String]?, isFavorite: Bool?, properties: JSONValue?, aspectNames: [String]?, path: PathInfo?) {
        self._id = _id
        self.expiresAt = expiresAt
        self.nodeId = nodeId
        self.name = name
        self.title = title
        self._description = _description
        self.modifiedAt = modifiedAt
        self.modifiedByUser = modifiedByUser
        self.sharedByUser = sharedByUser
        self.content = content
        self.allowableOperations = allowableOperations
        self.allowableOperationsOnTarget = allowableOperationsOnTarget
        self.isFavorite = isFavorite
        self.properties = properties
        self.aspectNames = aspectNames
        self.path = path
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case expiresAt
        case nodeId
        case name
        case title
        case _description = "description"
        case modifiedAt
        case modifiedByUser
        case sharedByUser
        case content
        case allowableOperations
        case allowableOperationsOnTarget
        case isFavorite
        case properties
        case aspectNames
        case path
    }


}

