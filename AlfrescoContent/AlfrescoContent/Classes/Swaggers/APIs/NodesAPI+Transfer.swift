//
// Copyright (C) 2005-2021 Alfresco Software Limited.
//
// This file is part of the Alfresco Content Mobile iOS App.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import Foundation
import Alamofire

extension NodesAPI {
    public class func createNode(nodeId: String,
                    nodeBody: NodeBodyCreate,
                    fileData: Data,
                    autoRename: Bool? = nil,
                    description: String? = nil,
                    majorVersion: Bool? = nil,
                    versioningEnabled: Bool? = nil,
                    include: [String]? = nil,
                    fields: [String]? = nil,
                    completion: @escaping ((_ data: NodeEntry?,_ error: Error?) -> Void)) {
        let requestBuilder = NodesAPI.createNodeWithRequestBuilder(nodeId: nodeId,
                                                                   nodeBodyCreate: nodeBody,
                                                                   autoRename: autoRename,
                                                                   include: include,
                                                                   fields: fields)
        guard let url = URL(string: requestBuilder.URLString) else { return }

        Alamofire.upload(multipartFormData: { (formData) in
            add(fileData: fileData,
                      description: description,
                      to: formData,
                      from: nodeBody)
        }, to: url,
        headers: AlfrescoContentAPI.customHeaders,
        encodingCompletion: { encodingResult in
            handle(encodingResult: encodingResult,
                   completionHandler: completion)
        })
    }

    private class func add(fileData: Data,
                     description: String?,
                     to formData: MultipartFormData,
                     from nodeBody: NodeBodyCreate) {
        if let dataNodeType = nodeBody.nodeType.data(using: .utf8),
           let dataAutoRename = "true".data(using: .utf8) {

            formData.append(fileData,
                            withName: "filedata",
                            fileName: nodeBody.name,
                            mimeType: "")
            formData.append(dataNodeType, withName: "nodeType")
            formData.append(dataAutoRename, withName: "autoRename")
        }
        if let description = description,
           let dataDescription = description.data(using: .utf8) {
            formData.append(dataDescription, withName: "cm:description")
        }
    }

    private class func handle(encodingResult: SessionManager.MultipartFormDataEncodingResult,
                        completionHandler: @escaping ((_ data: NodeEntry?,_ error: Error?) -> Void)) {
        switch encodingResult {
        case .success(let upload, _, _) :
            upload.responseJSON { response in
                if let error = response.error {
                    completionHandler(nil, error)
                } else {
                    if let data = response.data {
                        let resultDecode = decode(data: data)
                        if let nodeEntry = resultDecode.0 {
                            completionHandler(nodeEntry, nil)
                        }
                        if let error = resultDecode.1 {
                            completionHandler(nil, error)
                        }
                    }
                }
            }
        case .failure(let encodingError):
            completionHandler(nil, encodingError)
        }
    }

    private class func decode(data: Data) -> (NodeEntry?, Error?) {
        let decodeResult: (decodableObj: NodeEntry?, error: Error?)
        decodeResult = CodableHelper.decode(NodeEntry.self, from: data)
        if let error = decodeResult.error {
            return (nil, error)
        } else if let nodeEntry = decodeResult.decodableObj {
            return (nodeEntry, nil)
        }
        return (nil, nil)
    }
}
