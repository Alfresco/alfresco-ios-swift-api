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

let kRequestDefaultsFieldName = "keywords"
let kListPageSize = 25

struct SearchRequestBuilder {
    static func recentRequest(_ accountIdentifier: String, pagination: RequestPagination?) -> SearchRequest {
        return SearchRequest(query: self.requestQuery(""),
                             paging: pagination ?? self.requestPagination(),
                             include: self.requestInclude(),
                             includeRequest: nil,
                             fields: nil, sort: self.recentRequestSort(),
                             templates: nil,
                             defaults: nil,
                             localization: nil,
                             filterQueries: self.recentRequestFilter(accountIdentifier),
                             facetQueries: nil,
                             facetFields: nil,
                             facetIntervals: nil,
                             pivots: nil,
                             stats: nil,
                             spellcheck: nil,
                             scope: nil,
                             limits: nil,
                             highlight: nil,
                             ranges: nil)
    }

    // MARK: - Common

    private static func requestQuery(_ string: String) -> RequestQuery {
        return RequestQuery(language: .afts, userQuery: nil, query: string + "*")
    }

    private static func requestPagination() -> RequestPagination {
        return RequestPagination(maxItems: kListPageSize, skipCount: 0)
    }

    private static func requestInclude() -> RequestInclude {
        return ["path"]
    }

    // MARK: - Recent

    private static func recentRequestSort() -> [RequestSortDefinitionInner] {
           return [RequestSortDefinitionInner(type: .field,
                                              field: "cm:modified",
                                              ascending: false)]
       }

    private static func recentRequestFilter(_ accountIdentifier: String) -> [RequestFilterQueriesInner] {
        return [RequestFilterQueriesInner(query: "cm:modified:[NOW/DAY-30DAYS TO NOW/DAY+1DAY]", tags: nil),
                RequestFilterQueriesInner(query: "cm:modifier:\(accountIdentifier) OR cm:creator:\(accountIdentifier)", tags: nil),
                RequestFilterQueriesInner(query: "TYPE:\"content\" AND -PNAME:\"0/wiki\" AND -TYPE:\"app:filelink\" AND -TYPE:\"cm:thumbnail\" AND -TYPE:\"cm:failedThumbnail\" AND -TYPE:\"cm:rating\" AND -TYPE:\"dl:dataList\" AND -TYPE:\"dl:todoList\" AND -TYPE:\"dl:issue\" AND -TYPE:\"dl:contact\" AND -TYPE:\"dl:eventAgenda\" AND -TYPE:\"dl:event\" AND -TYPE:\"dl:task\" AND -TYPE:\"dl:simpletask\" AND -TYPE:\"dl:meetingAgenda\" AND -TYPE:\"dl:location\" AND -TYPE:\"fm:topic\" AND -TYPE:\"fm:post\" AND -TYPE:\"ia:calendarEvent\" AND -TYPE:\"lnk:link\"", tags: nil)]
    }
}
