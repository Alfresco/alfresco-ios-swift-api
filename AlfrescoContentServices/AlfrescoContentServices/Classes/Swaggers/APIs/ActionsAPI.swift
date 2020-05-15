//
// ActionsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class ActionsAPI {
    /**
     Retrieve the details of an action definition
     
     - parameter actionDefinitionId: (path) The identifier of an action definition. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func actionDetails(actionDefinitionId: String, completion: @escaping ((_ data: ActionDefinitionEntry?,_ error: Error?) -> Void)) {
        actionDetailsWithRequestBuilder(actionDefinitionId: actionDefinitionId).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Retrieve the details of an action definition
     - GET /alfresco/versions/1/action-definitions/{actionDefinitionId}
     - **Note:** this endpoint is available in Alfresco 5.2 and newer versions.  Retrieve the details of the action denoted by **actionDefinitionId**. 
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "entry" : {
    "applicableTypes" : [ "applicableTypes", "applicableTypes" ],
    "parameterDefinitions" : [ {
      "displayLabel" : "displayLabel",
      "name" : "name",
      "type" : "type",
      "multiValued" : true,
      "mandatory" : true
    }, {
      "displayLabel" : "displayLabel",
      "name" : "name",
      "type" : "type",
      "multiValued" : true,
      "mandatory" : true
    } ],
    "name" : "name",
    "trackStatus" : true,
    "description" : "description",
    "id" : "id",
    "title" : "title"
  }
}}]
     
     - parameter actionDefinitionId: (path) The identifier of an action definition. 

     - returns: RequestBuilder<ActionDefinitionEntry> 
     */
    open class func actionDetailsWithRequestBuilder(actionDefinitionId: String) -> RequestBuilder<ActionDefinitionEntry> {
        var path = "/alfresco/versions/1/action-definitions/{actionDefinitionId}"
        let actionDefinitionIdPreEscape = "\(actionDefinitionId)"
        let actionDefinitionIdPostEscape = actionDefinitionIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{actionDefinitionId}", with: actionDefinitionIdPostEscape, options: .literal, range: nil)
        let URLString = AlfrescoContentServicesAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<ActionDefinitionEntry>.Type = AlfrescoContentServicesAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Execute an action
     
     - parameter actionBodyExec: (body) Action execution details 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func actionExec(actionBodyExec: ActionBodyExec, completion: @escaping ((_ data: ActionExecResultEntry?,_ error: Error?) -> Void)) {
        actionExecWithRequestBuilder(actionBodyExec: actionBodyExec).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Execute an action
     - POST /alfresco/versions/1/action-executions
     - **Note:** this endpoint is available in Alfresco 5.2 and newer versions.  Executes an action  An action may be executed against a node specified by **targetId**. For example:  ``` {   \"actionDefinitionId\": \"copy\",   \"targetId\": \"4c4b3c43-f18b-43ff-af84-751f16f1ddfd\",   \"params\": {     \"destination-folder\": \"34219f79-66fa-4ebf-b371-118598af898c\"   } } ```  Performing a POST with the request body shown above will result in the node identified by ```targetId``` being copied to the destination folder specified in the ```params``` object by the key ```destination-folder```.  **targetId** is optional, however, currently **targetId** must be a valid node ID. In the future, actions may be executed against different entity types or executed without the need for the context of an entity.   Parameters supplied to the action within the ```params``` object will be converted to the expected type, where possible using the DefaultTypeConverter class. In addition:  * Node IDs may be supplied in their short form (implicit workspace://SpacesStore prefix) * Aspect names may be supplied using their short form, e.g. cm:versionable or cm:auditable  In this example, we add the aspect ```cm:versionable``` to a node using the QName resolution mentioned above:  ``` {   \"actionDefinitionId\": \"add-features\",   \"targetId\": \"16349e3f-2977-44d1-93f2-73c12b8083b5\",   \"params\": {     \"aspect-name\": \"cm:versionable\"   } } ```  The ```actionDefinitionId``` is the ```id``` of an action definition as returned by the _list actions_ operations (e.g. GET /action-definitions).  The action will be executed **asynchronously** with a `202` HTTP response signifying that the request has been accepted successfully. The response body contains the unique ID of the action pending execution. The ID may be used, for example to correlate an execution with output in the server logs. 
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "entry" : {
    "id" : "id"
  }
}}]
     
     - parameter actionBodyExec: (body) Action execution details 

     - returns: RequestBuilder<ActionExecResultEntry> 
     */
    open class func actionExecWithRequestBuilder(actionBodyExec: ActionBodyExec) -> RequestBuilder<ActionExecResultEntry> {
        let path = "/alfresco/versions/1/action-executions"
        let URLString = AlfrescoContentServicesAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: actionBodyExec)

        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<ActionExecResultEntry>.Type = AlfrescoContentServicesAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Retrieve list of available actions
     
     - parameter skipCount: (query) The number of entities that exist in the collection before those included in this list.  If not supplied then the default value is 0.  (optional, default to 0)
     - parameter maxItems: (query) The maximum number of items to return in the list.  If not supplied then the default value is 100.  (optional, default to 100)
     - parameter orderBy: (query) A string to control the order of the entities returned in a list. You can use the **orderBy** parameter to sort the list by one or more fields.  Each field has a default sort order, which is normally ascending order. Read the API method implementation notes above to check if any fields used in this method have a descending default search order.  To sort the entities in a specific order, you can use the **ASC** and **DESC** keywords for any field.  (optional)
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func listActions(skipCount: Int? = nil, maxItems: Int? = nil, orderBy: [String]? = nil, fields: [String]? = nil, completion: @escaping ((_ data: ActionDefinitionList?,_ error: Error?) -> Void)) {
        listActionsWithRequestBuilder(skipCount: skipCount, maxItems: maxItems, orderBy: orderBy, fields: fields).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Retrieve list of available actions
     - GET /alfresco/versions/1/action-definitions
     - **Note:** this endpoint is available in Alfresco 5.2.2 and newer versions.  Gets a list of all available actions  The default sort order for the returned list is for actions to be sorted by ascending name. You can override the default by using the **orderBy** parameter.  You can use any of the following fields to order the results: * name * title 
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "list" : {
    "entries" : [ {
      "applicableTypes" : [ "applicableTypes", "applicableTypes" ],
      "parameterDefinitions" : [ {
        "displayLabel" : "displayLabel",
        "name" : "name",
        "type" : "type",
        "multiValued" : true,
        "mandatory" : true
      }, {
        "displayLabel" : "displayLabel",
        "name" : "name",
        "type" : "type",
        "multiValued" : true,
        "mandatory" : true
      } ],
      "name" : "name",
      "trackStatus" : true,
      "description" : "description",
      "id" : "id",
      "title" : "title"
    }, {
      "applicableTypes" : [ "applicableTypes", "applicableTypes" ],
      "parameterDefinitions" : [ {
        "displayLabel" : "displayLabel",
        "name" : "name",
        "type" : "type",
        "multiValued" : true,
        "mandatory" : true
      }, {
        "displayLabel" : "displayLabel",
        "name" : "name",
        "type" : "type",
        "multiValued" : true,
        "mandatory" : true
      } ],
      "name" : "name",
      "trackStatus" : true,
      "description" : "description",
      "id" : "id",
      "title" : "title"
    } ],
    "pagination" : {
      "maxItems" : 5,
      "hasMoreItems" : true,
      "totalItems" : 6,
      "count" : 0,
      "skipCount" : 1
    }
  }
}}]
     
     - parameter skipCount: (query) The number of entities that exist in the collection before those included in this list.  If not supplied then the default value is 0.  (optional, default to 0)
     - parameter maxItems: (query) The maximum number of items to return in the list.  If not supplied then the default value is 100.  (optional, default to 100)
     - parameter orderBy: (query) A string to control the order of the entities returned in a list. You can use the **orderBy** parameter to sort the list by one or more fields.  Each field has a default sort order, which is normally ascending order. Read the API method implementation notes above to check if any fields used in this method have a descending default search order.  To sort the entities in a specific order, you can use the **ASC** and **DESC** keywords for any field.  (optional)
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)

     - returns: RequestBuilder<ActionDefinitionList> 
     */
    open class func listActionsWithRequestBuilder(skipCount: Int? = nil, maxItems: Int? = nil, orderBy: [String]? = nil, fields: [String]? = nil) -> RequestBuilder<ActionDefinitionList> {
        let path = "/alfresco/versions/1/action-definitions"
        let URLString = AlfrescoContentServicesAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "skipCount": skipCount?.encodeToJSON(), 
            "maxItems": maxItems?.encodeToJSON(), 
            "orderBy": orderBy, 
            "fields": fields
        ])

        let requestBuilder: RequestBuilder<ActionDefinitionList>.Type = AlfrescoContentServicesAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Retrieve actions for a node
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter skipCount: (query) The number of entities that exist in the collection before those included in this list.  If not supplied then the default value is 0.  (optional, default to 0)
     - parameter maxItems: (query) The maximum number of items to return in the list.  If not supplied then the default value is 100.  (optional, default to 100)
     - parameter orderBy: (query) A string to control the order of the entities returned in a list. You can use the **orderBy** parameter to sort the list by one or more fields.  Each field has a default sort order, which is normally ascending order. Read the API method implementation notes above to check if any fields used in this method have a descending default search order.  To sort the entities in a specific order, you can use the **ASC** and **DESC** keywords for any field.  (optional)
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func nodeActions(nodeId: String, skipCount: Int? = nil, maxItems: Int? = nil, orderBy: [String]? = nil, fields: [String]? = nil, completion: @escaping ((_ data: ActionDefinitionList?,_ error: Error?) -> Void)) {
        nodeActionsWithRequestBuilder(nodeId: nodeId, skipCount: skipCount, maxItems: maxItems, orderBy: orderBy, fields: fields).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Retrieve actions for a node
     - GET /alfresco/versions/1/nodes/{nodeId}/action-definitions
     - **Note:** this endpoint is available in Alfresco 5.2 and newer versions.  Retrieve the list of actions that may be executed against the given **nodeId**.  The default sort order for the returned list is for actions to be sorted by ascending name. You can override the default by using the **orderBy** parameter.  You can use any of the following fields to order the results: * name * title 
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "list" : {
    "entries" : [ {
      "applicableTypes" : [ "applicableTypes", "applicableTypes" ],
      "parameterDefinitions" : [ {
        "displayLabel" : "displayLabel",
        "name" : "name",
        "type" : "type",
        "multiValued" : true,
        "mandatory" : true
      }, {
        "displayLabel" : "displayLabel",
        "name" : "name",
        "type" : "type",
        "multiValued" : true,
        "mandatory" : true
      } ],
      "name" : "name",
      "trackStatus" : true,
      "description" : "description",
      "id" : "id",
      "title" : "title"
    }, {
      "applicableTypes" : [ "applicableTypes", "applicableTypes" ],
      "parameterDefinitions" : [ {
        "displayLabel" : "displayLabel",
        "name" : "name",
        "type" : "type",
        "multiValued" : true,
        "mandatory" : true
      }, {
        "displayLabel" : "displayLabel",
        "name" : "name",
        "type" : "type",
        "multiValued" : true,
        "mandatory" : true
      } ],
      "name" : "name",
      "trackStatus" : true,
      "description" : "description",
      "id" : "id",
      "title" : "title"
    } ],
    "pagination" : {
      "maxItems" : 5,
      "hasMoreItems" : true,
      "totalItems" : 6,
      "count" : 0,
      "skipCount" : 1
    }
  }
}}]
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter skipCount: (query) The number of entities that exist in the collection before those included in this list.  If not supplied then the default value is 0.  (optional, default to 0)
     - parameter maxItems: (query) The maximum number of items to return in the list.  If not supplied then the default value is 100.  (optional, default to 100)
     - parameter orderBy: (query) A string to control the order of the entities returned in a list. You can use the **orderBy** parameter to sort the list by one or more fields.  Each field has a default sort order, which is normally ascending order. Read the API method implementation notes above to check if any fields used in this method have a descending default search order.  To sort the entities in a specific order, you can use the **ASC** and **DESC** keywords for any field.  (optional)
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)

     - returns: RequestBuilder<ActionDefinitionList> 
     */
    open class func nodeActionsWithRequestBuilder(nodeId: String, skipCount: Int? = nil, maxItems: Int? = nil, orderBy: [String]? = nil, fields: [String]? = nil) -> RequestBuilder<ActionDefinitionList> {
        var path = "/alfresco/versions/1/nodes/{nodeId}/action-definitions"
        let nodeIdPreEscape = "\(nodeId)"
        let nodeIdPostEscape = nodeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{nodeId}", with: nodeIdPostEscape, options: .literal, range: nil)
        let URLString = AlfrescoContentServicesAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "skipCount": skipCount?.encodeToJSON(), 
            "maxItems": maxItems?.encodeToJSON(), 
            "orderBy": orderBy, 
            "fields": fields
        ])

        let requestBuilder: RequestBuilder<ActionDefinitionList>.Type = AlfrescoContentServicesAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
