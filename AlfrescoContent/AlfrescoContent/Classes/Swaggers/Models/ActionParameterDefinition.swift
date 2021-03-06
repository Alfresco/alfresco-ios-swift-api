//
// ActionParameterDefinition.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ActionParameterDefinition: Codable {

    public var name: String?
    public var type: String?
    public var multiValued: Bool?
    public var mandatory: Bool?
    public var displayLabel: String?

    public init(name: String?, type: String?, multiValued: Bool?, mandatory: Bool?, displayLabel: String?) {
        self.name = name
        self.type = type
        self.multiValued = multiValued
        self.mandatory = mandatory
        self.displayLabel = displayLabel
    }


}

