//
// RequestSpellcheck.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation


/** Request that spellcheck fragments to be added to result set rows The properties reflect SOLR spellcheck parameters.  */

public struct RequestSpellcheck: Codable {

    public var query: String?

    public init(query: String?) {
        self.query = query
    }


}
