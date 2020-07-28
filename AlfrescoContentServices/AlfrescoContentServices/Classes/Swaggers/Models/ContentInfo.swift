//
// ContentInfo.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation



public struct ContentInfo: Codable {

    public var mimeType: String
    public var mimeTypeName: String?
    public var sizeInBytes: Int64
    public var encoding: String?
    public var mimeTypeGroup: String?

    public init(mimeType: String, mimeTypeName: String?, sizeInBytes: Int64, encoding: String?, mimeTypeGroup: String?) {
        self.mimeType = mimeType
        self.mimeTypeName = mimeTypeName
        self.sizeInBytes = sizeInBytes
        self.encoding = encoding
        self.mimeTypeGroup = mimeTypeGroup
    }


}
