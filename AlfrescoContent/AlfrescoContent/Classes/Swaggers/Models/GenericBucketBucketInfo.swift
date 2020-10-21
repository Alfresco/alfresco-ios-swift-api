//
// GenericBucketBucketInfo.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Additional information of nested facet */

public struct GenericBucketBucketInfo: Codable {

    /** The start of range */
    public var start: String?
    /** Includes values greater or equal to \&quot;start\&quot; */
    public var startInclusive: Bool?
    /** The end of range */
    public var end: String?
    /** Includes values less than or equal to \&quot;end\&quot; */
    public var endInclusive: Bool?

    public init(start: String?, startInclusive: Bool?, end: String?, endInclusive: Bool?) {
        self.start = start
        self.startInclusive = startInclusive
        self.end = end
        self.endInclusive = endInclusive
    }


}
