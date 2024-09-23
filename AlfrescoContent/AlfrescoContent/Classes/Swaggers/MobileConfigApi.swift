//
//  MobileConfigApi.swift
//  AlfrescoContent
//
//  Created by Vinay Piplani on 11/09/24.
//

import Foundation

open class MobileConfigApi: NSObject {

    open class func getMobileConfig(appConfig: String,withCallback completion: @escaping ((_ data: MobileConfigData?,_ error: Error?) -> Void)) {
        self.mobileConfig(appConfig: appConfig).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - GET Config Json
        This API is used to fetch list of menu. This is GET request
     */
    class func mobileConfig(appConfig: String) -> RequestBuilder<MobileConfigData> {
        let URLString = AlfrescoContentAPI.hostname + appConfig
        let parameters: [String:Any]? = nil
        let requestBuilder: RequestBuilder<MobileConfigData>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        // Create the request and set the appropriate headers
            let urlRequest = requestBuilder.init(method: "GET", URLString: URLString, parameters: parameters, isBody: false)

            // Set cache-control headers to force fetching the fresh data
            urlRequest.addHeader(name: "Cache-Control", value: "no-cache, no-store, must-revalidate")
            urlRequest.addHeader(name: "Pragma", value: "no-cache")
            urlRequest.addHeader(name: "Expires", value: "0")

            return urlRequest
    }
}
