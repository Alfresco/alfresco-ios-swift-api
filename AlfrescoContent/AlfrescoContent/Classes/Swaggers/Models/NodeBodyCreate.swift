//
// NodeBodyCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct NodeBodyCreate: Codable {

    /** The name must not contain spaces or the following special characters: * \&quot; &lt; &gt; \\ / ? : and |. The character . must not be used at the end of the name.  */
    public var name: String
    public var nodeType: String
    public var aspectNames: [String]?
    public var properties: JSONValue?
    public var permissions: PermissionsBody?
    public var definition: Definition?
    public var relativePath: String?
    public var association: NodeBodyCreateAssociation?
    public var secondaryChildren: [ChildAssociationBody]?
    public var targets: [AssociationBody]?

    public init(name: String, nodeType: String, aspectNames: [String]?, properties: JSONValue?, permissions: PermissionsBody?, definition: Definition?, relativePath: String?, association: NodeBodyCreateAssociation?, secondaryChildren: [ChildAssociationBody]?, targets: [AssociationBody]?) {
        self.name = name
        self.nodeType = nodeType
        self.aspectNames = aspectNames
        self.properties = properties
        self.permissions = permissions
        self.definition = definition
        self.relativePath = relativePath
        self.association = association
        self.secondaryChildren = secondaryChildren
        self.targets = targets
    }


}

