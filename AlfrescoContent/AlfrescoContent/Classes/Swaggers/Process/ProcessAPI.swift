//
//  ProcessAPI.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 24/03/23.
//

import Foundation

// MARK: - Process APIs
open class ProcessAPI: NSObject {
    
    // MARK: - Check if APS is enabled
    open class func checkIfAPSIsEnabled(withCallback completion: @escaping ((_ data: ProcessSystemProperties?,_ error: Error?) -> Void)) {
        self.isAPSEnabled().execute { response, error in
            completion(response?.body, error)
        }
    }
    
    class func isAPSEnabled() -> RequestBuilder<ProcessSystemProperties> {
        let path = "/system/properties"
        let URLString = AlfrescoProcessAPI.basePath + path
        let requestBuilder: RequestBuilder<ProcessSystemProperties>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (URLString), parameters: nil, isBody: false)
    }
    
    
    // MARK: - Process List
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
    
    // MARK: - Link ADW Content to APS
    open class func linkContentToProcess(params: ProcessRequestLinkContent, withCallback completion: @escaping ((_ data: ProcessContentDetails?,_ error: Error?) -> Void)) {
        self.linkContentToAPS(params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - POST Link ADW Content to APS API Call
        This API is used to link ADW content on APS. This is POST request
     */
    class func linkContentToAPS(params: ProcessRequestLinkContent) -> RequestBuilder<ProcessContentDetails> {
        let path = "/content"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)
        let requestBuilder: RequestBuilder<ProcessContentDetails>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (URLString), parameters: parameters, isBody: true)
    }
    
    // MARK: - Single Process Definition
    public class func processDefinition(appDefinitionId: String?, latest: Bool? = true, withCallback completion: @escaping ((_ data: ProcessDefinition?,_ error: Error?) -> Void)) {
        
        self.getProcessDefinition(appDefinitionId: appDefinitionId, latest: latest).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Process definition API call
        This API is used to get the details of a single process. This is GET request
     */
    class func getProcessDefinition(appDefinitionId: String?, latest: Bool?) -> RequestBuilder<ProcessDefinition> {
        let path = "/process-definitions"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "latest": latest,
            "appDefinitionId": appDefinitionId
        ])
        
        let requestBuilder: RequestBuilder<ProcessDefinition>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    // MARK: - Runtime app Definition
    public class func runtimeAppDefinition(withCallback completion: @escaping ((_ data: WorkflowAppDefinition?,_ error: Error?) -> Void)) {
        
        self.getRuntimeAppDefinition().execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Run time app definition API call
        This API is used to get the details of run time process. This is GET request
     */
    class func getRuntimeAppDefinition() -> RequestBuilder<WorkflowAppDefinition> {
        let path = "/runtime-app-definitions"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<WorkflowAppDefinition>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
