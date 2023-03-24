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
    
    public init(sort: String?, state: ProcessStates?) {
        self.sort = sort
        self.state = state
    }
}


