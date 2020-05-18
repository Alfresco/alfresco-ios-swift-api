//
// RequestFacetField.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** A simple facet field */

public struct RequestFacetField: Codable {

    public enum Sort: String, Codable { 
        case count = "COUNT"
        case index = "INDEX"
    }
    public enum Method: String, Codable { 
        case _enum = "ENUM"
        case fc = "FC"
    }
    /** The facet field */
    public var field: String?
    /** A label to include in place of the facet field */
    public var label: String?
    /** Restricts the possible constraints to only indexed values with a specified prefix. */
    public var _prefix: String?
    public var sort: Sort?
    public var method: Method?
    /** When true, count results that match the query but which have no facet value for the field (in addition to the Term-based constraints). */
    public var missing: Bool?
    public var limit: Int?
    public var offset: Int?
    /** The minimum count required for a facet field to be included in the response. */
    public var mincount: Int?
    public var facetEnumCacheMinDf: Int?
    /** Filter Queries with tags listed here will not be included in facet counts. This is used for multi-select facetting.  */
    public var excludeFilters: [String]?

    public init(field: String?, label: String?, _prefix: String?, sort: Sort?, method: Method?, missing: Bool?, limit: Int?, offset: Int?, mincount: Int?, facetEnumCacheMinDf: Int?, excludeFilters: [String]?) {
        self.field = field
        self.label = label
        self._prefix = _prefix
        self.sort = sort
        self.method = method
        self.missing = missing
        self.limit = limit
        self.offset = offset
        self.mincount = mincount
        self.facetEnumCacheMinDf = facetEnumCacheMinDf
        self.excludeFilters = excludeFilters
    }

    public enum CodingKeys: String, CodingKey { 
        case field
        case label
        case _prefix = "prefix"
        case sort
        case method
        case missing
        case limit
        case offset
        case mincount
        case facetEnumCacheMinDf
        case excludeFilters
    }


}

