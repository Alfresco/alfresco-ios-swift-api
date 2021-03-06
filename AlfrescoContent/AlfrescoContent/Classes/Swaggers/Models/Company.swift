//
// Company.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Company: Codable {

    public var organization: String?
    public var address1: String?
    public var address2: String?
    public var address3: String?
    public var postcode: String?
    public var telephone: String?
    public var fax: String?
    public var email: String?

    public init(organization: String?, address1: String?, address2: String?, address3: String?, postcode: String?, telephone: String?, fax: String?, email: String?) {
        self.organization = organization
        self.address1 = address1
        self.address2 = address2
        self.address3 = address3
        self.postcode = postcode
        self.telephone = telephone
        self.fax = fax
        self.email = email
    }


}

