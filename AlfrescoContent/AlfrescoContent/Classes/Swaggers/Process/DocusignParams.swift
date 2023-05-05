//
//  DocusignParams.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 05/05/23.
//

import Foundation

// MARK: - Create Envelope
public struct DocusignCreateEnvelopeParams: Codable {

    public var contentId: String?
    public var docName: String?
    public var docType: String?
    public var signerEmail: String?
    public var signerName: String?
    public var returnUrl: String?

    public init(contentId: String?,
                docName: String?,
                docType: String?,
                signerEmail: String?,
                signerName: String?,
                returnUrl: String?) {
        self.contentId = contentId
        self.docName = docName
        self.docType = docType
        self.signerEmail = signerEmail
        self.signerName = signerName
        self.returnUrl = returnUrl
    }
}


// MARK: - Get Envelope
public struct DocusignEnvelopeDetailParams: Codable {

    public var taskid: String?
    public var envelopeId: String?
    public var fileName: String?

    public init(taskid: String?,
                envelopeId: String?,
                fileName: String?) {
        self.taskid = taskid
        self.envelopeId = envelopeId
        self.fileName = fileName
    }
}
