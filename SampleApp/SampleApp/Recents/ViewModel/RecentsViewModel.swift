//
// Copyright (C) 2005-2020 Alfresco Software Limited.
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
import AlfrescoContent
import AlfrescoAuth

protocol RecentsViewModelDelegate: AnyObject {
    func didLoadRecents()
    func didLogout()
    func didRefreshSession()
}

class RecentsViewModel {
    var authenticationProvider: AuthenticationProviderProtocol?
    var authenticationService: AuthenticationService?

    var ssoCredential: AlfrescoCredential?

    var nodes: [ListNode]?
    weak var delegate: RecentsViewModelDelegate?

    func fetchRecentsList() {
        guard let provider = authenticationProvider else { return }
        AlfrescoContentAPI.customHeaders = provider.authorizationHeader()
        getProcessList()
    }
    
    func getProcessList() {
        /*
        // upload content example
        if let data = UIImage(named: "sample")?.pngData() {
            TasksAPI.uploadContentToWorkflow(fileData: data, fileName: "sample", mimeType: "jpeg") { data, error in
                print("*** upload content in workflow ***", data)
                print("*** error ***", error)
            }
        }
        
        // start process example
        let reviewer = ReviewerParams(email: "abc@example.com",
                                      firstName: "ank",
                                      lastName: "goy",
                                      id: 1)
        let params = StartProcessParams(message: "test",
                                        dueDate: "2023-04-30",
                                        attachmentIds: "10,20",
                                        priority: TaskPriority.medium,
                                        reviewer: reviewer,
                                        sendemailnotifications: false)
        
        let finalParams = StartProcessBodyCreate.init(name: "name param", processDefinitionId: "123", params: params)
        print("FINAL PARAMS \(finalParams)")
        ProcessAPI.startProcess(params: finalParams) { data, error in
            print("*** start process ***", data)
            print("*** error ***", error)
        }
         */
        
        // start form
        ProcessAPI.formFields(name: "singlereviewer7-2-23:1:36") { data, fields, error in
            print("*** error ***", error)
            print("*** start form fields ***", fields)
        }
    }

    func logout(on viewController: UIViewController) {
        if let credentials = ssoCredential {
            authenticationService?.logOut(onViewController: viewController, lastKnownCredential: credentials, delegate: self)
        } else {
            delegate?.didLogout()
        }
    }

    func refreshSession() {
        authenticationService?.refreshSession(delegate: self)
    }
    
    func loadAdvanceSearchConfiguration() {
//        QueriesAPI.loadAdvanceSearchConfigurations { configuration, error in
//        }
    }
}

extension RecentsViewModel: AlfrescoAuthDelegate {
    func didReceive(result: Result<AlfrescoCredential?, APIError>, session: AlfrescoAuthSession?) {
        switch result {
        case .success(let credential):
            DispatchQueue.main.async { [weak self] in
                guard let sSelf = self else { return }

                if let credential = credential {
                    sSelf.authenticationProvider = AIMSAuthenticationProvider(with: credential)
                }
                sSelf.delegate?.didRefreshSession()
            }
        case .failure(let error):
            print(error)
        }
    }
    
    func didLogOut(result: Result<Int, APIError>, session: AlfrescoAuthSession?) {
        authenticationService?.session = nil
        authenticationProvider = nil
        delegate?.didLogout()
    }
}
