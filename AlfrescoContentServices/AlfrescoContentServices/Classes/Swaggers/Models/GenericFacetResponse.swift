//
// GenericFacetResponse.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct GenericFacetResponse: Codable {

    /** The facet type, eg. interval, range, pivot, stats */
    public var type: String?
    /** The field name or its explicit label, if provided on the request */
    public var label: String?
    /** An array of buckets and values */
    public var buckets: [GenericBucket]?

    public init(type: String?, label: String?, buckets: [GenericBucket]?) {
        self.type = type
        self.label = label
        self.buckets = buckets
    }


}
