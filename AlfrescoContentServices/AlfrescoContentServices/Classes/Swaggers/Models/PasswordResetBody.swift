//
// PasswordResetBody.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct PasswordResetBody: Codable {

    /** the new password */
    public var password: String
    /** the workflow id provided in the reset password email */
    public var _id: String
    /** the workflow key provided in the reset password email */
    public var key: String

    public init(password: String, _id: String, key: String) {
        self.password = password
        self._id = _id
        self.key = key
    }

    public enum CodingKeys: String, CodingKey { 
        case password
        case _id = "id"
        case key
    }


}
