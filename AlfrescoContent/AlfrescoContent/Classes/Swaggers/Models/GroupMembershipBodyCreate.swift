//
// GroupMembershipBodyCreate.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct GroupMembershipBodyCreate: Codable {

    public enum MemberType: String, Codable { 
        case group = "GROUP"
        case person = "PERSON"
    }
    public var _id: String
    public var memberType: MemberType

    public init(_id: String, memberType: MemberType) {
        self._id = _id
        self.memberType = memberType
    }

    public enum CodingKeys: String, CodingKey { 
        case _id = "id"
        case memberType
    }


}

