//
//  ProcessAPI.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 24/03/23.
//

import Foundation

// MARK: - Process APIs
open class ProcessAPI: NSObject {
    
    open class func getProcessList(params: ProcessListParams, withCallback completion: @escaping ((_ data: ProcessList?,_ error: Error?) -> Void)) {
        self.listProcess(params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - POST Process list API call
        This API is used to fetch list of running or completed process from the server. This is POST request
     */
    class func listProcess(params: ProcessListParams) -> RequestBuilder<ProcessList> {
        let path = "/process-instances/query"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)
        let requestBuilder: RequestBuilder<ProcessList>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (URLString), parameters: parameters, isBody: true)
    }
}
