//
//  TasksAPI.swift
//  AlfrescoContent
//
//  Created by global on 04/07/22.
//

import Foundation

open class TasksAPI: NSObject {

    open class func getTasksList(params: TaskListParams, withCallback completion: @escaping ((_ data: TaskList?,_ error: Error?) -> Void)) {
        self.listTaks(params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Tasks list API call
        This API is used to fetch list of tasks from the server. This is GET request
     */
    class func listTaks(params: TaskListParams) -> RequestBuilder<TaskList> {
        let path = "/tasks/query"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)
        let requestBuilder: RequestBuilder<TaskList>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (URLString), parameters: parameters, isBody: true)
    }
}
