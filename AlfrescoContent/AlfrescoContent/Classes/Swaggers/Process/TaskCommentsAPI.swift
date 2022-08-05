//
//  TaskCommentsAPI.swift
//  AlfrescoContent
//
//  Created by global on 05/08/22.
//

import Foundation

open class TaskCommentsAPI: NSObject {

    // MARK: - Comments List
    /**
     - GET comments by task id
     This API is used to get comments of a task
     */
    
    open class func getTaskComments(with taskId: String, withCallback completion: @escaping ((_ data: Comments?, _ error: Error?) -> Void)) {
        self.taskComments(taskId: taskId).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    class func taskComments(taskId: String) -> RequestBuilder<Comments> {
        var path = "/tasks/{taskId}/comments"
        let preEscape = "\(taskId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{taskId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        let url = URLComponents(string: URLString)
        let parameters: [String:Any]? = nil

        let requestBuilder: RequestBuilder<Comments>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    // MARK: - Add Comment
    /**
     - POST comments by task id
     This API is used to post a comment on a task
     */
    
    open class func postTaskComment(taskId: String, params: TaskCommentParams, withCallback completion: @escaping ((_ data: TaskComment?,_ error: Error?) -> Void)) {
        self.addComment(taskId: taskId, params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    class func addComment(taskId: String, params: TaskCommentParams) -> RequestBuilder<TaskComment> {
        
        var path = "/tasks/{taskId}/comments"
        let preEscape = "\(taskId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{taskId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        let url = URLComponents(string: URLString)
                
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)
        let requestBuilder: RequestBuilder<TaskComment>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
}
