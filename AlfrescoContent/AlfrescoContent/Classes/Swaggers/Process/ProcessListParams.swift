//
//  ProcessListParams.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 24/03/23.
//

import Foundation

public enum ProcessStates: String, Codable {
    case running = "running"
    case completed = "completed"
}

public struct ProcessListParams: Codable {
    public var sort: String?
    public var state: ProcessStates?
    public var page: Int? = 0
    public var size: Int? = 25
    public var start: Int? = 0

    public init(sort: String? = "created-desc",
                state: ProcessStates?,
                page: Int?,
                size: Int? = 25,
                start: Int? = nil) {
        self.sort = sort
        self.state = state
        self.page = page
        self.size = size
        self.start = start
    }
}
