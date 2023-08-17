import Foundation

public enum SearchInclude: String {
    case files = "cm:content"
    case folders = "cm:folder"
}

public class SimpleSearchRequest {
    let querry: String
    var parentId: String?
    let skipCount: Int
    let maxItems: Int
    let searchInclude: [SearchInclude]
    var filterQueries : [String]
    
    public init(querry: String,
                parentId: String?,
                skipCount: Int,
                maxItems: Int,
                searchInclude: [SearchInclude],
                filterQueries: [String]) {
        self.querry = querry
        self.parentId = parentId
        self.skipCount = skipCount
        self.maxItems = maxItems
        self.searchInclude = searchInclude
        self.filterQueries = filterQueries
    }
}

public class RecentFilesRequest {
    let userId: String
    let days: Int
    let skipCount: Int
    let maxItems: Int

    public init(userId: String,
         days: Int,
         skipCount: Int,
         maxItems: Int) {
        self.userId = userId
        self.days = days
        self.skipCount = skipCount
        self.maxItems = maxItems
    }
}

extension SearchAPI {
    static var unsupportedTypes: RequestFilterQueries {
        return SearchAPI.makeFilterQuerries(filters: "-TYPE:'st:site'",
                                            "-TYPE:'cm:thumbnail' AND -TYPE:'cm:failedThumbnail' AND -TYPE:'cm:rating'",
                                            "-ASPECT:'st:siteContainer' AND -ASPECT:'sys:hidden'",
                                            "-TYPE:'dl:dataList' AND -TYPE:'dl:todoList'",
                                            "-TYPE:'dl:issue' AND -TYPE:'dl:task' AND -TYPE:'dl:simpletask'",
                                            "-TYPE:'dl:event' AND -TYPE:'dl:eventAgenda' AND -TYPE:'dl:meetingAgenda'",
                                            "-TYPE:'dl:contact' AND -TYPE:'dl:location'",
                                            "-TYPE:'fm:forum' AND -TYPE:'fm:topic' AND -TYPE:'fm:post'",
                                            "-TYPE:'app:filelink' AND -TYPE:'lnk:link' AND -TYPE:'ia:calendarEvent'",
                                            "-PNAME:'0/wiki'")
    }

    public class func simpleSearch(searchRequest: SimpleSearchRequest,
                                   facetFields: FacetFields?,
                                   facetQueries: FacetQueries?,
                                   facetIntervals: FacetIntervals?,
                                   completion: @escaping ((_ data: ResultSetPaging?,_ error: Error?) -> Void)) {
        let querry = requestQuery(searchRequest.querry + "*")
        let paginationRequest = requestPagination(maxItems: searchRequest.maxItems,
                                                  skipCount: searchRequest.skipCount)
        let include: RequestInclude = ["path", "allowableOperations"]
        let sort = [RequestSortDefinitionInner(type: .field,
                                               field: "score",
                                               ascending: false)]
        let templates = [RequestTemplatesInner(name: "keywords",
                                               template: "%(cm:name cm:title cm:description TEXT TAG)")]
        let defaults = RequestDefaults(textAttributes: nil,
                                       defaultFTSOperator: .and,
                                       defaultFTSFieldOperator: nil,
                                       namespace: nil,
                                       defaultFieldName: "keywords")

        var typeFilter: String
        if searchRequest.searchInclude.isEmpty {
            let defaultTypes = [SearchInclude.files, SearchInclude.folders]
            typeFilter = defaultTypes.map({ return "+TYPE:'\($0.rawValue)'" }).joined(separator: " OR ")
        } else {
            typeFilter = searchRequest.searchInclude.map({ return "+TYPE:'\($0.rawValue)'" }).joined(separator: " OR ")
        }

        var filter = makeFilterQuerries(filters: typeFilter) + SearchAPI.unsupportedTypes
        if !searchRequest.filterQueries.isEmpty {
            for item in searchRequest.filterQueries {
                let filterQuery = makeFilterQuerries(filters: item)
                filter = filter + filterQuery
            }
        }
            
        if let parentId = searchRequest.parentId {
            let parentIdFilter = "ANCESTOR:'workspace://SpacesStore/\(parentId)'"
            filter.append(contentsOf: makeFilterQuerries(filters: parentIdFilter))
        }

        let searchRequest = SearchRequest(query: querry,
                                          paging: paginationRequest,
                                          include: include,
                                          includeRequest: nil,
                                          fields: nil,
                                          sort: sort,
                                          templates: templates,
                                          defaults: nil,
                                          localization: nil,
                                          filterQueries: filter,
                                          facetQueries: facetQueries,
                                          facetFields: facetFields,
                                          facetIntervals: facetIntervals,
                                          pivots: nil,
                                          stats: nil,
                                          spellcheck: nil,
                                          scope: nil,
                                          limits: nil,
                                          highlight: nil,
                                          ranges: nil,
                                          facetFormat: "V2")
        SearchAPI.search(queryBody: searchRequest,
                         completion: completion)
    }

    public class func recentFiles(recentFilesRequest: RecentFilesRequest,
                           completion: @escaping ((_ data: ResultSetPaging?,_ error: Error?) -> Void)) {
        let querry = requestQuery("*")
        let paginationRequest = requestPagination(maxItems: recentFilesRequest.maxItems,
                                                  skipCount: recentFilesRequest.skipCount)
        let include: RequestInclude = ["path", "allowableOperations", "isFavorite"]
        let sort = [RequestSortDefinitionInner(type: .field,
                                           field: "cm:modified",
                                           ascending: false)]
        let filter = makeFilterQuerries(filters: "cm:modified:[NOW/DAY-\(recentFilesRequest.days)DAYS TO NOW/DAY+1DAY]",
                                        "cm:modifier:\(recentFilesRequest.userId) OR cm:creator:\(recentFilesRequest.userId)",
                                        "TYPE:'content'") + SearchAPI.unsupportedTypes

        let searchRequest = SearchRequest(query: querry,
                                          paging: paginationRequest,
                                          include: include,
                                          includeRequest: nil,
                                          fields: nil,
                                          sort: sort,
                                          templates: nil,
                                          defaults: nil,
                                          localization: nil,
                                          filterQueries: filter,
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
        SearchAPI.search(queryBody: searchRequest,
                         completion: completion)
    }

    private class func requestQuery(_ string: String) -> RequestQuery {
        return RequestQuery(language: .afts, userQuery: nil, query: string)
    }

    private static func requestPagination(maxItems: Int, skipCount: Int) -> RequestPagination {
        return RequestPagination(maxItems: maxItems, skipCount: skipCount)
    }

    private static func makeFilterQuerries(filters: String...) -> RequestFilterQueries {
        return filters.map { filter -> RequestFilterQueriesInner in
            return RequestFilterQueriesInner(query: filter, tags: nil)
        }
    }
}
