//
// ActionExecResult.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ActionExecResult: Codable {

    /** The unique identifier of the action pending execution */
    public var _id: String

    public init(_id: String) {
        self._id = _id
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
    }


}

