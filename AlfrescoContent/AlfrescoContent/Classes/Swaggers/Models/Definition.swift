//
// Definition.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Definition: Codable {

    /** List of property definitions effective for this node as the result of combining the type with all aspects. */
    public var properties: [Property]?

    public init(properties: [Property]?) {
        self.properties = properties
    }


}

