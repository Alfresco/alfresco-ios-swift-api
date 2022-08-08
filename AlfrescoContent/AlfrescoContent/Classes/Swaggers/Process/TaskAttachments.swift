//
//  TaskAttachments.swift
//  AlfrescoContent
//
//  Created by global on 09/08/22.
//

import Foundation

// MARK: - Task attachments
public class TaskAttachmentsModel: Codable {
    public var size: Int
    public var total: Int
    public var start: Int
    public var data = [TaskAttachment]()
}

// MARK: - Comment
public class TaskAttachment: Codable {
    public var id: Int?
    public var name: String?
    public var created: Date?
    public var createdBy: TaskAssignee?
    public var relatedContent = true
    public var contentAvailable = true
    public var link = false
    public var mimeType: String?
    public var simpleType: String?
    public var previewStatus: String?
    public var thumbnailStatus: String?
}
