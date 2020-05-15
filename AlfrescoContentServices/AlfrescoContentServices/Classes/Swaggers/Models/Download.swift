//
// Download.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct Download: Codable {

    public enum Status: String, Codable { 
        case pending = "PENDING"
        case cancelled = "CANCELLED"
        case inProgress = "IN_PROGRESS"
        case done = "DONE"
        case maxContentSizeExceeded = "MAX_CONTENT_SIZE_EXCEEDED"
    }
    /** number of files added so far in the zip */
    public var filesAdded: Int?
    /** number of bytes added so far in the zip */
    public var bytesAdded: Int?
    /** the id of the download node */
    public var _id: String?
    /** the total number of files to be added in the zip */
    public var totalFiles: Int?
    /** the total number of bytes to be added in the zip */
    public var totalBytes: Int?
    /** the current status of the download node creation */
    public var status: Status?

    public init(filesAdded: Int?, bytesAdded: Int?, _id: String?, totalFiles: Int?, totalBytes: Int?, status: Status?) {
        self.filesAdded = filesAdded
        self.bytesAdded = bytesAdded
        self._id = _id
        self.totalFiles = totalFiles
        self.totalBytes = totalBytes
        self.status = status
    }

    public enum CodingKeys: String, CodingKey { 
        case filesAdded
        case bytesAdded
        case _id = "id"
        case totalFiles
        case totalBytes
        case status
    }


}

