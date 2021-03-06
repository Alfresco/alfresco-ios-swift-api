//
// RequestPagination.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct RequestPagination: Codable {

    /** The maximum number of items to return in the query results */
    public var maxItems: Int?
    /** The number of items to skip from the start of the query set */
    public var skipCount: Int?

    public init(maxItems: Int?, skipCount: Int?) {
        self.maxItems = maxItems
        self.skipCount = skipCount
    }


}

