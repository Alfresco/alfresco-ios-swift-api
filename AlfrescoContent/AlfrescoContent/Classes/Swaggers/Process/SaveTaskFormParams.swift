//
//  SaveTaskFormParams.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 12/06/23.
//

import Foundation

public struct SaveTaskFormParams: Codable {
    public var values: SaveFormParams?
    public var outcome: String?

    public init(values: SaveFormParams?, outcome: String? = nil) {
        self.values = values
        self.outcome = outcome
    }
}

public struct SaveFormParams: Codable {
    var status: Option?
    var comment: String?
    
    public init(status: Option?,
                comment: String?) {
        self.status = status
        self.comment = comment
    }
}
