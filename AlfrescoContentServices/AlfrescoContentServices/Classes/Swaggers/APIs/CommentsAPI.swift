//
// CommentsAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class CommentsAPI {
    /**
     Create a comment
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter commentBodyCreate: (body) The comment text. Note that you can also provide a list of comments. 
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func createComment(nodeId: String, commentBodyCreate: CommentBody, fields: [String]? = nil, completion: @escaping ((_ data: CommentEntry?,_ error: Error?) -> Void)) {
        createCommentWithRequestBuilder(nodeId: nodeId, commentBodyCreate: commentBodyCreate, fields: fields).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Create a comment
     - POST /alfresco/versions/1/nodes/{nodeId}/comments
     - Creates a comment on node **nodeId**. You specify the comment in a JSON body like this:  ```JSON {   \"content\": \"This is a comment\" } ```  **Note:** You can create more than one comment by  specifying a list of comments in the JSON body like this:  ```JSON [   {     \"content\": \"This is a comment\"   },   {     \"content\": \"This is another comment\"   } ] ``` If you specify a list as input, then a paginated list rather than an entry is returned in the response body. For example:  ```JSON {   \"list\": {     \"pagination\": {       \"count\": 2,       \"hasMoreItems\": false,       \"totalItems\": 2,       \"skipCount\": 0,       \"maxItems\": 100     },     \"entries\": [       {         \"entry\": {           ...         }       },       {         \"entry\": {           ...         }       }     ]   } } ``` 
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "entry" : {
    "createdAt" : "2000-01-23T04:56:07.000+00:00",
    "createdBy" : {
      "googleId" : "googleId",
      "lastName" : "lastName",
      "userStatus" : "userStatus",
      "capabilities" : "{}",
      "displayName" : "displayName",
      "jobTitle" : "jobTitle",
      "statusUpdatedAt" : "2000-01-23T04:56:07.000+00:00",
      "mobile" : "mobile",
      "emailNotificationsEnabled" : true,
      "description" : "description",
      "telephone" : "telephone",
      "enabled" : true,
      "aspectNames" : [ "aspectNames", "aspectNames" ],
      "firstName" : "firstName",
      "skypeId" : "skypeId",
      "avatarId" : "avatarId",
      "instantMessageId" : "instantMessageId",
      "location" : "location",
      "company" : {
        "address3" : "address3",
        "address2" : "address2",
        "address1" : "address1",
        "organization" : "organization",
        "postcode" : "postcode",
        "telephone" : "telephone",
        "fax" : "fax",
        "email" : "email"
      },
      "id" : "id",
      "email" : "email",
      "properties" : "{}"
    },
    "edited" : true,
    "modifiedAt" : "2000-01-23T04:56:07.000+00:00",
    "canEdit" : true,
    "modifiedBy" : {
      "googleId" : "googleId",
      "lastName" : "lastName",
      "userStatus" : "userStatus",
      "capabilities" : "{}",
      "displayName" : "displayName",
      "jobTitle" : "jobTitle",
      "statusUpdatedAt" : "2000-01-23T04:56:07.000+00:00",
      "mobile" : "mobile",
      "emailNotificationsEnabled" : true,
      "description" : "description",
      "telephone" : "telephone",
      "enabled" : true,
      "aspectNames" : [ "aspectNames", "aspectNames" ],
      "firstName" : "firstName",
      "skypeId" : "skypeId",
      "avatarId" : "avatarId",
      "instantMessageId" : "instantMessageId",
      "location" : "location",
      "company" : {
        "address3" : "address3",
        "address2" : "address2",
        "address1" : "address1",
        "organization" : "organization",
        "postcode" : "postcode",
        "telephone" : "telephone",
        "fax" : "fax",
        "email" : "email"
      },
      "id" : "id",
      "email" : "email",
      "properties" : "{}"
    },
    "canDelete" : true,
    "id" : "id",
    "title" : "title",
    "content" : "content"
  }
}}]
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter commentBodyCreate: (body) The comment text. Note that you can also provide a list of comments. 
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)

     - returns: RequestBuilder<CommentEntry> 
     */
    open class func createCommentWithRequestBuilder(nodeId: String, commentBodyCreate: CommentBody, fields: [String]? = nil) -> RequestBuilder<CommentEntry> {
        var path = "/alfresco/versions/1/nodes/{nodeId}/comments"
        let nodeIdPreEscape = "\(nodeId)"
        let nodeIdPostEscape = nodeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{nodeId}", with: nodeIdPostEscape, options: .literal, range: nil)
        let URLString = AlfrescoContentServicesAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: commentBodyCreate)

        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "fields": fields
        ])

        let requestBuilder: RequestBuilder<CommentEntry>.Type = AlfrescoContentServicesAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "POST", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

    /**
     Delete a comment
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter commentId: (path) The identifier of a comment. 
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func deleteComment(nodeId: String, commentId: String, completion: @escaping ((_ data: Void?,_ error: Error?) -> Void)) {
        deleteCommentWithRequestBuilder(nodeId: nodeId, commentId: commentId).execute { (response, error) -> Void in
            if error == nil {
                completion((), error)
            } else {
                completion(nil, error)
            }
        }
    }


    /**
     Delete a comment
     - DELETE /alfresco/versions/1/nodes/{nodeId}/comments/{commentId}
     - Deletes the comment **commentId** from node **nodeId**.
     - BASIC:
       - type: basic
       - name: basicAuth
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter commentId: (path) The identifier of a comment. 

     - returns: RequestBuilder<Void> 
     */
    open class func deleteCommentWithRequestBuilder(nodeId: String, commentId: String) -> RequestBuilder<Void> {
        var path = "/alfresco/versions/1/nodes/{nodeId}/comments/{commentId}"
        let nodeIdPreEscape = "\(nodeId)"
        let nodeIdPostEscape = nodeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{nodeId}", with: nodeIdPostEscape, options: .literal, range: nil)
        let commentIdPreEscape = "\(commentId)"
        let commentIdPostEscape = commentIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{commentId}", with: commentIdPostEscape, options: .literal, range: nil)
        let URLString = AlfrescoContentServicesAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        let url = URLComponents(string: URLString)

        let requestBuilder: RequestBuilder<Void>.Type = AlfrescoContentServicesAPI.requestBuilderFactory.getNonDecodableBuilder()

        return requestBuilder.init(method: "DELETE", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     List comments
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter skipCount: (query) The number of entities that exist in the collection before those included in this list.  If not supplied then the default value is 0.  (optional, default to 0)
     - parameter maxItems: (query) The maximum number of items to return in the list.  If not supplied then the default value is 100.  (optional, default to 100)
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func listComments(nodeId: String, skipCount: Int? = nil, maxItems: Int? = nil, fields: [String]? = nil, completion: @escaping ((_ data: CommentPaging?,_ error: Error?) -> Void)) {
        listCommentsWithRequestBuilder(nodeId: nodeId, skipCount: skipCount, maxItems: maxItems, fields: fields).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     List comments
     - GET /alfresco/versions/1/nodes/{nodeId}/comments
     - Gets a list of comments for the node **nodeId**, sorted chronologically with the newest comment first.
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "list" : {
    "entries" : [ {
      "entry" : {
        "createdAt" : "2000-01-23T04:56:07.000+00:00",
        "createdBy" : {
          "googleId" : "googleId",
          "lastName" : "lastName",
          "userStatus" : "userStatus",
          "capabilities" : "{}",
          "displayName" : "displayName",
          "jobTitle" : "jobTitle",
          "statusUpdatedAt" : "2000-01-23T04:56:07.000+00:00",
          "mobile" : "mobile",
          "emailNotificationsEnabled" : true,
          "description" : "description",
          "telephone" : "telephone",
          "enabled" : true,
          "aspectNames" : [ "aspectNames", "aspectNames" ],
          "firstName" : "firstName",
          "skypeId" : "skypeId",
          "avatarId" : "avatarId",
          "instantMessageId" : "instantMessageId",
          "location" : "location",
          "company" : {
            "address3" : "address3",
            "address2" : "address2",
            "address1" : "address1",
            "organization" : "organization",
            "postcode" : "postcode",
            "telephone" : "telephone",
            "fax" : "fax",
            "email" : "email"
          },
          "id" : "id",
          "email" : "email",
          "properties" : "{}"
        },
        "edited" : true,
        "modifiedAt" : "2000-01-23T04:56:07.000+00:00",
        "canEdit" : true,
        "modifiedBy" : {
          "googleId" : "googleId",
          "lastName" : "lastName",
          "userStatus" : "userStatus",
          "capabilities" : "{}",
          "displayName" : "displayName",
          "jobTitle" : "jobTitle",
          "statusUpdatedAt" : "2000-01-23T04:56:07.000+00:00",
          "mobile" : "mobile",
          "emailNotificationsEnabled" : true,
          "description" : "description",
          "telephone" : "telephone",
          "enabled" : true,
          "aspectNames" : [ "aspectNames", "aspectNames" ],
          "firstName" : "firstName",
          "skypeId" : "skypeId",
          "avatarId" : "avatarId",
          "instantMessageId" : "instantMessageId",
          "location" : "location",
          "company" : {
            "address3" : "address3",
            "address2" : "address2",
            "address1" : "address1",
            "organization" : "organization",
            "postcode" : "postcode",
            "telephone" : "telephone",
            "fax" : "fax",
            "email" : "email"
          },
          "id" : "id",
          "email" : "email",
          "properties" : "{}"
        },
        "canDelete" : true,
        "id" : "id",
        "title" : "title",
        "content" : "content"
      }
    }, {
      "entry" : {
        "createdAt" : "2000-01-23T04:56:07.000+00:00",
        "createdBy" : {
          "googleId" : "googleId",
          "lastName" : "lastName",
          "userStatus" : "userStatus",
          "capabilities" : "{}",
          "displayName" : "displayName",
          "jobTitle" : "jobTitle",
          "statusUpdatedAt" : "2000-01-23T04:56:07.000+00:00",
          "mobile" : "mobile",
          "emailNotificationsEnabled" : true,
          "description" : "description",
          "telephone" : "telephone",
          "enabled" : true,
          "aspectNames" : [ "aspectNames", "aspectNames" ],
          "firstName" : "firstName",
          "skypeId" : "skypeId",
          "avatarId" : "avatarId",
          "instantMessageId" : "instantMessageId",
          "location" : "location",
          "company" : {
            "address3" : "address3",
            "address2" : "address2",
            "address1" : "address1",
            "organization" : "organization",
            "postcode" : "postcode",
            "telephone" : "telephone",
            "fax" : "fax",
            "email" : "email"
          },
          "id" : "id",
          "email" : "email",
          "properties" : "{}"
        },
        "edited" : true,
        "modifiedAt" : "2000-01-23T04:56:07.000+00:00",
        "canEdit" : true,
        "modifiedBy" : {
          "googleId" : "googleId",
          "lastName" : "lastName",
          "userStatus" : "userStatus",
          "capabilities" : "{}",
          "displayName" : "displayName",
          "jobTitle" : "jobTitle",
          "statusUpdatedAt" : "2000-01-23T04:56:07.000+00:00",
          "mobile" : "mobile",
          "emailNotificationsEnabled" : true,
          "description" : "description",
          "telephone" : "telephone",
          "enabled" : true,
          "aspectNames" : [ "aspectNames", "aspectNames" ],
          "firstName" : "firstName",
          "skypeId" : "skypeId",
          "avatarId" : "avatarId",
          "instantMessageId" : "instantMessageId",
          "location" : "location",
          "company" : {
            "address3" : "address3",
            "address2" : "address2",
            "address1" : "address1",
            "organization" : "organization",
            "postcode" : "postcode",
            "telephone" : "telephone",
            "fax" : "fax",
            "email" : "email"
          },
          "id" : "id",
          "email" : "email",
          "properties" : "{}"
        },
        "canDelete" : true,
        "id" : "id",
        "title" : "title",
        "content" : "content"
      }
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
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)

     - returns: RequestBuilder<CommentPaging> 
     */
    open class func listCommentsWithRequestBuilder(nodeId: String, skipCount: Int? = nil, maxItems: Int? = nil, fields: [String]? = nil) -> RequestBuilder<CommentPaging> {
        var path = "/alfresco/versions/1/nodes/{nodeId}/comments"
        let nodeIdPreEscape = "\(nodeId)"
        let nodeIdPostEscape = nodeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{nodeId}", with: nodeIdPostEscape, options: .literal, range: nil)
        let URLString = AlfrescoContentServicesAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "skipCount": skipCount?.encodeToJSON(), 
            "maxItems": maxItems?.encodeToJSON(), 
            "fields": fields
        ])

        let requestBuilder: RequestBuilder<CommentPaging>.Type = AlfrescoContentServicesAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     Update a comment
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter commentId: (path) The identifier of a comment. 
     - parameter commentBodyUpdate: (body) The JSON representing the comment to be updated. 
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func updateComment(nodeId: String, commentId: String, commentBodyUpdate: CommentBody, fields: [String]? = nil, completion: @escaping ((_ data: CommentEntry?,_ error: Error?) -> Void)) {
        updateCommentWithRequestBuilder(nodeId: nodeId, commentId: commentId, commentBodyUpdate: commentBodyUpdate, fields: fields).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Update a comment
     - PUT /alfresco/versions/1/nodes/{nodeId}/comments/{commentId}
     - Updates an existing comment **commentId** on node **nodeId**.
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "entry" : {
    "createdAt" : "2000-01-23T04:56:07.000+00:00",
    "createdBy" : {
      "googleId" : "googleId",
      "lastName" : "lastName",
      "userStatus" : "userStatus",
      "capabilities" : "{}",
      "displayName" : "displayName",
      "jobTitle" : "jobTitle",
      "statusUpdatedAt" : "2000-01-23T04:56:07.000+00:00",
      "mobile" : "mobile",
      "emailNotificationsEnabled" : true,
      "description" : "description",
      "telephone" : "telephone",
      "enabled" : true,
      "aspectNames" : [ "aspectNames", "aspectNames" ],
      "firstName" : "firstName",
      "skypeId" : "skypeId",
      "avatarId" : "avatarId",
      "instantMessageId" : "instantMessageId",
      "location" : "location",
      "company" : {
        "address3" : "address3",
        "address2" : "address2",
        "address1" : "address1",
        "organization" : "organization",
        "postcode" : "postcode",
        "telephone" : "telephone",
        "fax" : "fax",
        "email" : "email"
      },
      "id" : "id",
      "email" : "email",
      "properties" : "{}"
    },
    "edited" : true,
    "modifiedAt" : "2000-01-23T04:56:07.000+00:00",
    "canEdit" : true,
    "modifiedBy" : {
      "googleId" : "googleId",
      "lastName" : "lastName",
      "userStatus" : "userStatus",
      "capabilities" : "{}",
      "displayName" : "displayName",
      "jobTitle" : "jobTitle",
      "statusUpdatedAt" : "2000-01-23T04:56:07.000+00:00",
      "mobile" : "mobile",
      "emailNotificationsEnabled" : true,
      "description" : "description",
      "telephone" : "telephone",
      "enabled" : true,
      "aspectNames" : [ "aspectNames", "aspectNames" ],
      "firstName" : "firstName",
      "skypeId" : "skypeId",
      "avatarId" : "avatarId",
      "instantMessageId" : "instantMessageId",
      "location" : "location",
      "company" : {
        "address3" : "address3",
        "address2" : "address2",
        "address1" : "address1",
        "organization" : "organization",
        "postcode" : "postcode",
        "telephone" : "telephone",
        "fax" : "fax",
        "email" : "email"
      },
      "id" : "id",
      "email" : "email",
      "properties" : "{}"
    },
    "canDelete" : true,
    "id" : "id",
    "title" : "title",
    "content" : "content"
  }
}}]
     
     - parameter nodeId: (path) The identifier of a node. 
     - parameter commentId: (path) The identifier of a comment. 
     - parameter commentBodyUpdate: (body) The JSON representing the comment to be updated. 
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)

     - returns: RequestBuilder<CommentEntry> 
     */
    open class func updateCommentWithRequestBuilder(nodeId: String, commentId: String, commentBodyUpdate: CommentBody, fields: [String]? = nil) -> RequestBuilder<CommentEntry> {
        var path = "/alfresco/versions/1/nodes/{nodeId}/comments/{commentId}"
        let nodeIdPreEscape = "\(nodeId)"
        let nodeIdPostEscape = nodeIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{nodeId}", with: nodeIdPostEscape, options: .literal, range: nil)
        let commentIdPreEscape = "\(commentId)"
        let commentIdPostEscape = commentIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{commentId}", with: commentIdPostEscape, options: .literal, range: nil)
        let URLString = AlfrescoContentServicesAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: commentBodyUpdate)

        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "fields": fields
        ])

        let requestBuilder: RequestBuilder<CommentEntry>.Type = AlfrescoContentServicesAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "PUT", URLString: (url?.string ?? URLString), parameters: parameters, isBody: true)
    }

}
