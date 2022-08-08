//
//  TaskAttachmentsAPI.swift
//  AlfrescoContent
//
//  Created by global on 09/08/22.
//

import UIKit

class TaskAttachmentsAPI: NSObject {

    // MARK: - Attachments List
    /**
     - GET attachments by task id
     This API is used to get attachments of a task
     */
    
    open class func getTaskAttachments(with taskId: String, withCallback completion: @escaping ((_ data: TaskAttachmentsModel?, _ error: Error?) -> Void)) {
        self.taskAttachments(taskId: taskId).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    class func taskAttachments(taskId: String) -> RequestBuilder<TaskAttachmentsModel> {
        var path = "/tasks/{taskId}/content"
        let preEscape = "\(taskId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{taskId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        let url = URLComponents(string: URLString)
        let parameters: [String:Any]? = nil

        let requestBuilder: RequestBuilder<TaskAttachmentsModel>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
