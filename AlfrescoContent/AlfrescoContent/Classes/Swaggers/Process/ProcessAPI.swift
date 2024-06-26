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
    
    // MARK: - Search Group
    public class func searchGroup(filter: String?, withCallback completion: @escaping ((_ data: TaskAssigneeUserList?,_ error: Error?) -> Void)) {
        
        self.searchGroupToAssignTask(filter: filter).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Tasks Assignee User List API call
        This API is used to fetch list of availble users to assin a task. This is GET request
     */
    class func searchGroupToAssignTask(filter: String?) -> RequestBuilder<TaskAssigneeUserList> {
        let path = "/groups"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "filter": filter
        ])
        
        let requestBuilder: RequestBuilder<TaskAssigneeUserList>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    // MARK: - Start Process Workflow
    /**
     - POST Start Process API call
        This API is used to start a process. This is POST request
     */
    open class func startWorkFlowProcess(params: StartWorkFlowBodyCreate, withCallback completion: @escaping ((_ data: Process?,_ error: Error?) -> Void)) {
        self.processInstance(params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    class func processInstance(params: StartWorkFlowBodyCreate) -> RequestBuilder<Process> {
        let path = "/process-instances"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)
        let requestBuilder: RequestBuilder<Process>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (URLString), parameters: parameters, isBody: true)
    }
    
    // MARK: - Start Form / Get Form fields
    public class func formFields(name: String?, withCallback completion: @escaping ((_ data: StartFormFields?, _ fields: [Field], _ error: Error?) -> Void)) {
        guard let name = name else { return }
        self.startForm(name: name).execute { response, error in
            let body = response?.body
            let fields = StartFormFieldOperation.processFormFields(for: body)
            completion(body, fields, error)
        }
    }
    
    /**
     - GET Get Form fields API call
        This API is used to fetch list of fields to start a form. This is GET request
     */
    class func startForm(name: String) -> RequestBuilder<StartFormFields> {
        let path = String(format: "/process-definitions/%@/start-form", name)
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters: [String:Any]? = nil
        let url = URLComponents(string: URLString)
        
        let requestBuilder: RequestBuilder<StartFormFields>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
    
    // MARK: - GET APS Source
    open class func getAPSSource(withCallback completion: @escaping ((_ data: APSAccountProfile?,_ error: Error?) -> Void)) {
        self.apsSource().execute { response, error in
            completion(response?.body, error)
        }
    }
    
    class func apsSource() -> RequestBuilder<APSAccountProfile> {
        let path = "/profile/accounts/alfresco"
        let URLString = AlfrescoProcessAPI.basePath + path
        let requestBuilder: RequestBuilder<APSAccountProfile>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (URLString), parameters: nil, isBody: false)
    }
}
