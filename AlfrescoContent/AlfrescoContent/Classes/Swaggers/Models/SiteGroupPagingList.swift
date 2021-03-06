//
// SiteGroupPagingList.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct SiteGroupPagingList: Codable {

    public var pagination: Pagination
    public var entries: [SiteGroupEntry]

    public init(pagination: Pagination, entries: [SiteGroupEntry]) {
        self.pagination = pagination
        self.entries = entries
    }


}

