//
// SharedLinkPagingList.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct SharedLinkPagingList: Codable {

    public var pagination: Pagination
    public var entries: [SharedLinkEntry]

    public init(pagination: Pagination, entries: [SharedLinkEntry]) {
        self.pagination = pagination
        self.entries = entries
    }


}

