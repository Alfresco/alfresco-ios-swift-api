//
// AuditEntryPagingList.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct AuditEntryPagingList: Codable {

    public var pagination: Pagination?
    public var entries: [AuditEntryEntry]?

    public init(pagination: Pagination?, entries: [AuditEntryEntry]?) {
        self.pagination = pagination
        self.entries = entries
    }


}

