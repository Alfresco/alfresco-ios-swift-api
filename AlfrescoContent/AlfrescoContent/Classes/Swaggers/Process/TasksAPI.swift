//
//  TasksAPI.swift
//  AlfrescoContent
//
//  Created by global on 04/07/22.
//

import Foundation
import Alamofire

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

// MARK: - Tasks Operations
extension TasksAPI {
    
    // MARK: - Create Task
    open class func createTask(params: TaskBodyCreate, withCallback completion: @escaping ((_ data: Task?,_ error: Error?) -> Void)) {
        self.createNewTask(params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Tasks list API call
        This API is used to fetch list of tasks from the server. This is POST request
     */
    class func createNewTask(params: TaskBodyCreate) -> RequestBuilder<Task> {
        let path = "/tasks"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)
        let requestBuilder: RequestBuilder<Task>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (URLString), parameters: parameters, isBody: true)
    }
    
    // MARK: - Update Task
    open class func updateTask(taskId: String, params: TaskBodyCreate, withCallback completion: @escaping ((_ data: Task?,_ error: Error?) -> Void)) {
        
        self.updateTaskDetails(taskId: taskId, params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - PUT Update Task API call
        This API is used to update task details. This is PUT request
     */
    class func updateTaskDetails(taskId: String, params: TaskBodyCreate) -> RequestBuilder<Task> {
        var path = "/tasks/{taskId}"
        let preEscape = "\(taskId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{taskId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        let url = URLComponents(string: URLString)
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)

        let requestBuilder: RequestBuilder<Task>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    
    // MARK: - Assign Task
    open class func assignTask(taskId: String, params: AssignUserBody, withCallback completion: @escaping ((_ data: Task?,_ error: Error?) -> Void)) {
        
        self.assignTaskDetails(taskId: taskId, params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - PUT Update Task Assignee API call
        This API is used to update task assignee. This is PUT request
     */
    class func assignTaskDetails(taskId: String, params: AssignUserBody) -> RequestBuilder<Task> {
        var path = "/tasks/{taskId}/action/assign"
        let preEscape = "\(taskId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{taskId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        let url = URLComponents(string: URLString)
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)

        let requestBuilder: RequestBuilder<Task>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    
    // MARK: - Search User
    open class func searchUser(filter: String?, email: String?, withCallback completion: @escaping ((_ data: TaskAssigneeUserList?,_ error: Error?) -> Void)) {
        
        self.searchUserToAssignTask(filter: filter, email: email).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Tasks Assignee User List API call
        This API is used to fetch list of availble users to assin a task. This is GET request
     */
    class func searchUserToAssignTask(filter: String?, email: String?) -> RequestBuilder<TaskAssigneeUserList> {
        let path = "/users"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "filter": filter,
            "email": email
        ])
        
        let requestBuilder: RequestBuilder<TaskAssigneeUserList>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    // MARK: - Upload Raw Content
    open class func uploadRawContent(taskId: String, fileData: Data, fileName: String, withCallback completion: @escaping ((_ data: TaskAttachment?,_ error: Error?) -> Void)) {
        
        let requestBuilder = TasksAPI.uploadAttachment(taskId: taskId)
        guard let url = URL(string: requestBuilder.URLString) else { return }

        Alamofire.upload(multipartFormData: { multipart in
            multipart.append(fileData, withName: "file", fileName: fileName, mimeType: "")
        }, to: url, method: .post, headers: AlfrescoContentAPI.customHeaders) { encodingResult in
            handle(encodingResult: encodingResult,
                   completionHandler: completion)
        }
    }
    
    class func uploadAttachment(taskId: String) -> RequestBuilder<TaskAttachment> {
        var path = "/tasks/{taskId}/raw-content"
        let preEscape = "\(taskId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{taskId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "isRelatedContent": true,
        ])
        
        let parameters: [String:Any]? = nil
        let requestBuilder: RequestBuilder<TaskAttachment>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }
    
    private class func handle(encodingResult: SessionManager.MultipartFormDataEncodingResult,
                        completionHandler: @escaping ((_ data: TaskAttachment?,_ error: Error?) -> Void)) {
        switch encodingResult {
        case .success(let upload, _, _) :
            upload.responseJSON { response in
                if let error = response.error {
                    completionHandler(nil, error)
                } else {
                    if let data = response.data {
                        let resultDecode = decode(data: data)
                        if let nodeEntry = resultDecode.0 {
                            completionHandler(nodeEntry, nil)
                        }
                        if let error = resultDecode.1 {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
        case .failure(let encodingError):
            completionHandler(nil, encodingError)
        }
    }
    
    private class func decode(data: Data) -> (TaskAttachment?, Error?) {
        let decodeResult: (decodableObj: TaskAttachment?, error: Error?)
        decodeResult = CodableHelper.decode(TaskAttachment.self, from: data)
        if let error = decodeResult.error {
            return (nil, error)
        } else if let nodeEntry = decodeResult.decodableObj {
            return (nodeEntry, nil)
        }
        return (nil, nil)
    }
    
    /**
     - DELETE attachment
        This API is used to delete attachment from a task. This is DELETE request
     */
    open class func deleteRawContent(contentId: String, withCallback completion: @escaping ((_ data: Void?, _ error: Error?) -> Void)) {
        
        self.deleteTaskAttachment(contentId: contentId).execute { response, error in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }
    
    class func deleteTaskAttachment(contentId: String) -> RequestBuilder<Void> {
        var path = "/content/{contentId}"
        let preEscape = "\(contentId)"
        let postEscape = preEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{contentId}", with: postEscape, options: .literal, range: nil)
        let URLString = AlfrescoProcessAPI.basePath + path
        let url = URLComponents(string: URLString)
        let parameters: [String:Any]? = nil

        let requestBuilder: RequestBuilder<Void>.Type = AlfrescoContentAPI.requestBuilderFactory.getNonDecodableBuilder()
        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
