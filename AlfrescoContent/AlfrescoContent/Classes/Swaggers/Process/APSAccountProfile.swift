//
//  APSAccountProfile.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 25/05/23.
//

import Foundation

public struct APSAccountProfile: Codable {

    public var size: Int?
    public var total: Int?
    public var start: Int?
    public var data: APSAccountDetails?
}

public struct APSAccountDetails: Codable {

    public var id: Int?
    public var tenantId: Int?
    public var created: Date?
    public var lastUpdated: Date?
    public var alfrescoTenantId: String?
    public var repositoryUrl: String?
    public var shareUrl: String?
    public var name: String?
    public var secret: String?
    public var authenticationType: String?
    public var version: String?
    public var sitesFolder: String?
}
