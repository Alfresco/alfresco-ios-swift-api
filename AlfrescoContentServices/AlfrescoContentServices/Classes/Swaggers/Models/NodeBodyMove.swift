//
// NodeBodyMove.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct NodeBodyMove: Codable {

    public var targetParentId: String
    /** The name must not contain spaces or the following special characters: * \&quot; &lt; &gt; \\ / ? : and |. The character . must not be used at the end of the name.  */
    public var name: String?

    public init(targetParentId: String, name: String?) {
        self.targetParentId = targetParentId
        self.name = name
    }


}

