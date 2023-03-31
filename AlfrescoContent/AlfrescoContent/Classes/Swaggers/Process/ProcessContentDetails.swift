//
//  ProcessContentDetails.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 31/03/23.
//

import Foundation

// MARK: Process Content details
public class ProcessContentDetails: Codable {
    public var id: Int?
    public var name: String?
    public var created: String?
    public var createdBy: ProcessUser?
    public var relatedContent: Bool?
    public var contentAvailable: Bool?
    public var link: Bool?
    public var source: String?
    public var sourceId: String?
    public var mimeType: String?
    public var simpleType: String?
    public var previewStatus: String?
    public var thumbnailStatus: String?
}
