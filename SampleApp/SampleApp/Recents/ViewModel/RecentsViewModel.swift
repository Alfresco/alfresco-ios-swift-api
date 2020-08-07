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

protocol RecentsViewModelDelegate: class {
    func didLoadRecents()
}

class RecentsViewModel {
    var authenticationProvider: AuthenticationProviderProtocol?
    var nodes: [ListNode]?
    weak var delegate: RecentsViewModelDelegate?

    func fetchRecentsList() {
        guard let provider = authenticationProvider else { return }
        AlfrescoContentAPI.customHeaders = provider.authorizationHeader()

        SearchAPI.search(queryBody: SearchRequestBuilder.recentRequest(provider.identifier(), pagination: nil)) { [weak self] (result, error) in
            guard let sSelf = self else { return }
            var listNodes: [ListNode]?
            if let entries = result?.list?.entries {
                listNodes = ResultsNodeMapper.map(entries)

                sSelf.nodes = listNodes
                sSelf.delegate?.didLoadRecents()
            } else {
                if let error = error {
                    print(error)
                }
            }
        }
    }
}
