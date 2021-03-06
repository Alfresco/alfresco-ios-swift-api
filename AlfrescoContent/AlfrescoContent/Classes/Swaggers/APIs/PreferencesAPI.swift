//
// PreferencesAPI.swift
//
// Generated by swagger-codegen
// https://github.com/swagger-api/swagger-codegen
//

import Foundation
import Alamofire



open class PreferencesAPI {
    /**
     Get a preference
     
     - parameter personId: (path) The identifier of a person. 
     - parameter preferenceName: (path) The name of the preference. 
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func getPreference(personId: String, preferenceName: String, fields: [String]? = nil, completion: @escaping ((_ data: PreferenceEntry?,_ error: Error?) -> Void)) {
        getPreferenceWithRequestBuilder(personId: personId, preferenceName: preferenceName, fields: fields).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     Get a preference
     - GET /alfresco/versions/1/people/{personId}/preferences/{preferenceName}
     - Gets a specific preference for person **personId**.  You can use the `-me-` string in place of `<personId>` to specify the currently authenticated user. 
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "entry" : {
    "id" : "id",
    "value" : "value"
  }
}}]
     
     - parameter personId: (path) The identifier of a person. 
     - parameter preferenceName: (path) The name of the preference. 
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)

     - returns: RequestBuilder<PreferenceEntry> 
     */
    open class func getPreferenceWithRequestBuilder(personId: String, preferenceName: String, fields: [String]? = nil) -> RequestBuilder<PreferenceEntry> {
        var path = "/alfresco/versions/1/people/{personId}/preferences/{preferenceName}"
        let personIdPreEscape = "\(personId)"
        let personIdPostEscape = personIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{personId}", with: personIdPostEscape, options: .literal, range: nil)
        let preferenceNamePreEscape = "\(preferenceName)"
        let preferenceNamePostEscape = preferenceNamePreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{preferenceName}", with: preferenceNamePostEscape, options: .literal, range: nil)
        let URLString = AlfrescoContentAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "fields": fields
        ])

        let requestBuilder: RequestBuilder<PreferenceEntry>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

    /**
     List preferences
     
     - parameter personId: (path) The identifier of a person. 
     - parameter skipCount: (query) The number of entities that exist in the collection before those included in this list. If not supplied then the default value is 0.  (optional, default to 0)
     - parameter maxItems: (query) The maximum number of items to return in the list. If not supplied then the default value is 100.  (optional, default to 100)
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)
     - parameter completion: completion handler to receive the data and the error objects
     */
    open class func listPreferences(personId: String, skipCount: Int? = nil, maxItems: Int? = nil, fields: [String]? = nil, completion: @escaping ((_ data: PreferencePaging?,_ error: Error?) -> Void)) {
        listPreferencesWithRequestBuilder(personId: personId, skipCount: skipCount, maxItems: maxItems, fields: fields).execute { (response, error) -> Void in
            completion(response?.body, error)
        }
    }


    /**
     List preferences
     - GET /alfresco/versions/1/people/{personId}/preferences
     - Gets a list of preferences for person **personId**.  You can use the `-me-` string in place of `<personId>` to specify the currently authenticated user. Note that each preference consists of an **id** and a **value**.  The **value** can be of any JSON type. 
     - BASIC:
       - type: basic
       - name: basicAuth
     - examples: [{contentType=application/json, example={
  "list" : {
    "entries" : [ {
      "entry" : {
        "id" : "id",
        "value" : "value"
      }
    }, {
      "entry" : {
        "id" : "id",
        "value" : "value"
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
     
     - parameter personId: (path) The identifier of a person. 
     - parameter skipCount: (query) The number of entities that exist in the collection before those included in this list. If not supplied then the default value is 0.  (optional, default to 0)
     - parameter maxItems: (query) The maximum number of items to return in the list. If not supplied then the default value is 100.  (optional, default to 100)
     - parameter fields: (query) A list of field names.  You can use this parameter to restrict the fields returned within a response if, for example, you want to save on overall bandwidth.  The list applies to a returned individual entity or entries within a collection.  If the API method also supports the **include** parameter, then the fields specified in the **include** parameter are returned in addition to those specified in the **fields** parameter.  (optional)

     - returns: RequestBuilder<PreferencePaging> 
     */
    open class func listPreferencesWithRequestBuilder(personId: String, skipCount: Int? = nil, maxItems: Int? = nil, fields: [String]? = nil) -> RequestBuilder<PreferencePaging> {
        var path = "/alfresco/versions/1/people/{personId}/preferences"
        let personIdPreEscape = "\(personId)"
        let personIdPostEscape = personIdPreEscape.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) ?? ""
        path = path.replacingOccurrences(of: "{personId}", with: personIdPostEscape, options: .literal, range: nil)
        let URLString = AlfrescoContentAPI.basePath + path
        let parameters: [String:Any]? = nil
        
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "skipCount": skipCount?.encodeToJSON(), 
            "maxItems": maxItems?.encodeToJSON(), 
            "fields": fields
        ])

        let requestBuilder: RequestBuilder<PreferencePaging>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()

        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }

}
