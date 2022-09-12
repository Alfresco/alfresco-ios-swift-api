//
//  UserProfile.swift
//  AlfrescoContent
//
//  Created by global on 12/09/22.
//

import Foundation

open class UserProfile: NSObject {

    open class func getUserProfile(withCallback completion: @escaping ((_ data: UserData?,_ error: Error?) -> Void)) {
        self.userProfile().execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Tasks Filters API call
        This API is used to fetch list of availble filters. This is GET request
     */
    class func userProfile() -> RequestBuilder<UserData> {
        let path = "/profile"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters: [String:Any]? = nil
        let requestBuilder: RequestBuilder<UserData>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (URLString), parameters: parameters, isBody: false)
    }
}
