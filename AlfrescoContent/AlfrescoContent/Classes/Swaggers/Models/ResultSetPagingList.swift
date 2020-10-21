//
// ResultSetPagingList.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ResultSetPagingList: Codable {

    public var pagination: Pagination?
    public var context: ResultSetContext?
    public var entries: [ResultSetRowEntry]?

    public init(pagination: Pagination?, context: ResultSetContext?, entries: [ResultSetRowEntry]?) {
        self.pagination = pagination
        self.context = context
        self.entries = entries
    }


}
