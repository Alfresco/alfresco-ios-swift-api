//
//  TasksAPI.swift
//  AlfrescoContent
//
//  Created by global on 04/07/22.
//

import Foundation

open class TasksAPI: NSObject {

    open class func getTasksList(params: TaskListParams, withCallback completion: @escaping ((_ data: TaskList?,_ error: Error?) -> Void)) {
        self.listTasks(params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Tasks list API call
        This API is used to fetch list of tasks from the server. This is POST request
     */
    class func listTasks(params: TaskListParams) -> RequestBuilder<TaskList> {
        let path = "/tasks/query"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)
        let requestBuilder: RequestBuilder<TaskList>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (URLString), parameters: parameters, isBody: true)
    }
    
    open class func getTasksFilters(withCallback completion: @escaping ((_ data: TaskFiltersList?,_ error: Error?) -> Void)) {
        self.tasksFilter().execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Tasks Filters API call
        This API is used to fetch list of availble filters. This is GET request
     */
    class func tasksFilter() -> RequestBuilder<TaskFiltersList> {
        let path = "/filters/tasks"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters: [String:Any]? = nil
        let requestBuilder: RequestBuilder<TaskFiltersList>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (URLString), parameters: parameters, isBody: false)
    }
    
    /**
     - GET task detail by id
     This API is used to get detail of a task
     */
    
    open class func getTasksDetails(with taskId: String, withCallback completion: @escaping ((_ data: Task?, _ error: Error?) -> Void)) {
        self.taskDetails(taskId: taskId).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    class func taskDetails(taskId: String) -> RequestBuilder<Task> {
        var path = "/tasks/{taskId}"
        let preEscape = "\(taskId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{taskId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        let url = URLComponents(string: URLString)
        let parameters: [String:Any]? = nil

        let requestBuilder: RequestBuilder<Task>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    
    /**
     - PUT complete taskl by id
     This API is used to complete a task
     */
    
    open class func completeTask(with taskId: String, withCallback completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) {
        
        self.markTaskAsComplete(taskId: taskId).execute { response, error in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func markTaskAsComplete(taskId: String) -> RequestBuilder<Void> {
        var path = "/tasks/{taskId}/action/complete"
        let preEscape = "\(taskId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{taskId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        let url = URLComponents(string: URLString)
        let parameters: [String:Any]? = nil

        let requestBuilder: RequestBuilder<Void>.Type = AlfrescoContentAPI.requestBuilderFactory.getNonDecodableBuilder()
        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
