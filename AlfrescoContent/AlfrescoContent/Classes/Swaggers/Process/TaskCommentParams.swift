//
//  TaskCommentParams.swift
//  AlfrescoContent
//
//  Created by global on 05/08/22.
//

import Foundation

public struct TaskCommentParams: Codable {
    public var message: String
    
    public init(message: String) {
        self.message = message
    }
}

