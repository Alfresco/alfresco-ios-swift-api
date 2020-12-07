import Foundation

enum SearchInclude: String {
    case files = "cm:content"
    case folders = "cm:folder"
}

class SimpleSearchRequest {
    let querry: String
    var parentId: String?
    let skipCount: Int
    let maxItems: Int
    let include: [SearchInclude]

    init(querry: String,
         parentId: String?,
         skipCount: Int,
         maxItems: Int,
         include: [SearchInclude]) {
        self.querry = querry
        self.parentId = parentId
        self.skipCount = skipCount
        self.maxItems = maxItems
        self.include = include
    }
}

class RecentFilesRequest {
    let userId: String
    let days: Int
    let skipCount: Int
    let maxItems: Int

    init(userId: String,
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
        return SearchAPI.makeFilterQuerries(filters: "-TYPE:'cm:thumbnail' AND -TYPE:'cm:failedThumbnail' AND -TYPE:'cm:rating'",
                                  "-cm:creator:System AND -QNAME:comment",
                                  "-TYPE:'st:site' AND -ASPECT:'st:siteContainer' AND -ASPECT:'sys:hidden'",
                                  "-TYPE:'dl:dataList' AND -TYPE:'dl:todoList' AND -TYPE:'dl:issue'",
                                  "-TYPE:'fm:topic' AND -TYPE:'fm:post'",
                                  "-TYPE:'lnk:link'",
                                  "-PNAME:'0/wiki'")
    }


    class func simpleSearch(searchRequest: SimpleSearchRequest,
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
        if include.isEmpty {
            let defaultTypes = [SearchInclude.files.rawValue, SearchInclude.folders.rawValue].joined(separator: " OR ")
            typeFilter = defaultTypes
        } else {
            typeFilter = include.map({ return "+TYPE:'\($0)'" }).joined(separator: " OR ")
        }

        var filter = makeFilterQuerries(filters: typeFilter) + SearchAPI.unsupportedTypes

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
                                          defaults: defaults,
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

    class func recentFiles(recentFilesRequest: RecentFilesRequest,
                           completion: @escaping ((_ data: ResultSetPaging?,_ error: Error?) -> Void)) {
        let querry = requestQuery("*")
        let paginationRequest = requestPagination(maxItems: recentFilesRequest.maxItems,
                                                  skipCount: recentFilesRequest.skipCount)
        let include: RequestInclude = ["path", "allowableOperations"]
        let sort = [RequestSortDefinitionInner(type: .field,
                                           field: "cm:modified",
                                           ascending: false)]
        var filter = makeFilterQuerries(filters: "cm:modified:[NOW/DAY-\(recentFilesRequest.days)DAYS TO NOW/DAY+1DAY]",
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
        var querries: RequestFilterQueries = []

        return filters.map { filter -> RequestFilterQueriesInner in
            return RequestFilterQueriesInner(query: filter, tags: nil)
        }
    }
}
