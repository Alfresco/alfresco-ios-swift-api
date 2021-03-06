//
// RequestPivot.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** A list of pivots. */

public struct RequestPivot: Codable {

    /** A key corresponding to a matching field facet label or stats. */
    public var key: String?
    public var pivots: [RequestPivot]?

    public init(key: String?, pivots: [RequestPivot]?) {
        self.key = key
        self.pivots = pivots
    }


}

