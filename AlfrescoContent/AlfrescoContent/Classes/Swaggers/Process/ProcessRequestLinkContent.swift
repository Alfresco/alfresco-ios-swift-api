//
//  ProcessRequestLinkContent.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 31/03/23.
//

import Foundation

public struct ProcessRequestLinkContent: Codable {
    public var source: String?
    public var mimeType: String?
    public var sourceId: String?
    public var name: String?

    public init(source: String?,
                mimeType: String?,
                sourceId: String?,
                name: String?) {
        self.source = source
        self.mimeType = mimeType
        self.sourceId = sourceId
        self.name = name
    }
}
