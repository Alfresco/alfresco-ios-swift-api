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
import SwiftUI

// MARK: Advance Search Model
public class SearchConfigModel: Codable {
    public var search = [AdvanceSearchFilters]()
}

// MARK: Advance Search Model
public class AdvanceSearchFilters: Codable {
    public var filterWithContains: Bool?
    public var resetButton: Bool?
    public var name: String?
    public var isDefault: Bool? = false
    public var filterQueries = [FilterQueries]()
    public var categories = [SearchCategories]()
    public var facetFields: FacetFields?
    public var facetQueries: FacetQueries?
    public var facetIntervals: FacetIntervals?

    enum CodingKeys: String, CodingKey {
        case filterWithContains
        case resetButton
        case name
        case isDefault = "default"
        case filterQueries
        case categories
        case facetFields
        case facetQueries
        case facetIntervals
    }
}

// MARK: Filter Queries
public class FilterQueries: Codable {
    public var query: String?
}


// MARK: Search Categories
public class SearchCategories: Codable {
    public var searchID: String?
    public var name: String?
    public var enabled: Bool?
    public var expanded: Bool?
    public var component: SearchComponents?
    
    enum CodingKeys: String, CodingKey {
        case searchID = "id"
        case name
        case enabled
        case expanded
        case component
    }
}

// MARK: Search Components
public class SearchComponents: Codable {
    public var selector: String?
    public var settings: SearchComponentSettings?
}

// MARK: Search Component Settings
public class SearchComponentSettings: Codable {
    public var pattern: String?
    public var field: String?
    public var placeholder: String?
    public var pageSize: Int?
    public var searchOperator: String?
    public var min: Int?
    public var max: Int?
    public var step: Int?
    public var thumbLabel: Bool?
    public var format: String?
    public var dateFormat: String?
    public var maxDate: String?
    public var options: [SearchComponentOptions]?
    public var selectedValue: String?
    
    enum CodingKeys: String, CodingKey {
        case pattern
        case field
        case placeholder
        case pageSize
        case searchOperator = "operator"
        case min
        case max
        case step
        case thumbLabel
        case format
        case dateFormat
        case maxDate
        case options
        case selectedValue
    }
}

// MARK: Search Component Options
public class SearchComponentOptions: Codable {
    public var name: String?
    public var value: String?
    public var isDefault: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case name
        case value
        case isDefault = "default"
    }
}

// MARK: - Facet Fields
public class FacetFields: Codable {
    public var expanded: Bool? = false
    public var fields = [Fields]()
}

public class Fields: Codable {
    public var field: String?
    public var mincount: Int?
    public var label: String?
}

// MARK: - Facet Queries
public class FacetQueries: Codable {
    public var label: String?
    public var pageSize: Int?
    public var expanded: Bool?
    public var mincount: Int?
    public var queries = [Queries]()
}

public class Queries: Codable {
    public var query: String?
    public var label: String?
    public var group: String?
}

// MARK: - Facet Intervals
public class FacetIntervals: Codable {
    public var intervals = [Intervals]()
}

public class Intervals: Codable {
    public var label: String?
    public var field: String?
    public var sets = [Sets]()
}

public class Sets: Codable {
    public var label: String?
    public var start: String?
    public var end: String?
    public var endInclusive: Bool? = false
}
