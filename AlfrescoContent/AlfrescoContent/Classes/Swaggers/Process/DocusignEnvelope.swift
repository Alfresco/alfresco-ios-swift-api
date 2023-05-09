//
//  DocusignEnvelope.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 05/05/23.
//

import Foundation

// MARK: Docusign envelpoe
public class DocusignEnvelope: Codable {
    public var contentId: String?
    public var docName: String?
    public var docType: String?
    public var signerEmail: String?
    public var signerName: String?
    public var returnUrl: String?
    public var base64Data: String?
    public var envelopID: String?
    public var viewUrl: String?
    public var message: String?

    enum CodingKeys: String, CodingKey {
        case contentId
        case docName
        case docType
        case signerEmail
        case signerName
        case returnUrl, base64Data, envelopID, viewUrl, message
    }
}

// MARK: Docusign envelpoe details
public class DocusignEnvelopeDetails: Codable {
    public var id: Int?
    public var name: String?
    public var created: String?
    public var createdBy: TaskAssignee?
    public var relatedContent: Bool?
    public var contentAvailable: Bool?
    public var link: Bool?
    public var mimeType: String?
    public var simpleType: String?
    public var previewStatus: String?
    public var thumbnailStatus: String?
}
