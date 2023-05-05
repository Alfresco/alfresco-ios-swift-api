//
//  DocusignAPIs.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 05/05/23.
//

import Foundation
import Alamofire

open class DocusignAPIs: NSObject {
    
    open class func createEnvelope(params: DocusignCreateEnvelopeParams?,
                                   withCallback completion: @escaping ((_ data: DocusignEnvelope?,_ error: Error?) -> Void)) {
        self.docusignCreateEnvelope(params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    /**
     - POST create envelope for docusign - API call
        This API is used to create an envelope for docusign. This is POST request
     */
    class func docusignCreateEnvelope(params: DocusignCreateEnvelopeParams?) -> RequestBuilder<DocusignEnvelope> {
        let path = "/integration/docusign/signdoc"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters = JSONEncodingHelper.encodingParameters(forEncodableObject: params)
        let requestBuilder: RequestBuilder<DocusignEnvelope>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "POST", URLString: (URLString), parameters: parameters, isBody: true)
    }
    
    /**
     - GET Envelope details API call
     This API is used to GET the details of envelope. This is GET request
     */
    
    open class func envelopeDetails(params: DocusignEnvelopeDetailParams?, withCallback completion: @escaping ((_ data: DocusignEnvelopeDetails?, _ error: Error?) -> Void)) {
        self.getEnvelopeDetails(params: params).execute { response, error in
            completion(response?.body, error)
        }
    }
    
    class func getEnvelopeDetails(params: DocusignEnvelopeDetailParams?) -> RequestBuilder<DocusignEnvelopeDetails> {
        let path = "/integration/docusign/getSignedDoc"
        let URLString = AlfrescoProcessAPI.basePath + path
        let parameters: [String:Any]? = nil
        var url = URLComponents(string: URLString)
        url?.queryItems = APIHelper.mapValuesToQueryItems([
            "taskid": params?.taskid,
            "envelopeId": params?.envelopeId,
            "fileName": params?.fileName
        ])

        let requestBuilder: RequestBuilder<DocusignEnvelopeDetails>.Type = AlfrescoContentAPI.requestBuilderFactory.getBuilder()
        return requestBuilder.init(method: "GET", URLString: (url?.string ?? URLString), parameters: parameters, isBody: false)
    }
}
