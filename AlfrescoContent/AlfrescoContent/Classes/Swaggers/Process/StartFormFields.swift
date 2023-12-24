//
//  StartFormFields.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 01/05/23.
//

import Foundation


// MARK: start form fields
public class StartFormFields: Codable {
    public let id: Int
    public let name: String?
    public let processDefinitionID, processDefinitionName, processDefinitionKey: String
    public let taskID: String?
    public let taskName: String?
    public let taskDefinitionKey: String?
    public let tabs: [JSONAny]
    public let fields: [Field]
    public let outcomes: [Outcome]
    public let javascriptEvents: [JSONAny]
    public let selectedOutcome: String?
    public let className, style: String
    public let customFieldTemplates, metadata: CustomFieldTemplates
    public let variables: [JSONAny]
    public let customFieldsValueInfo: CustomFieldTemplates
    public let gridsterForm: Bool
    public let globalDateFormat: String
    
    enum CodingKeys: String, CodingKey {
        case id, name
        case processDefinitionID = "processDefinitionId"
        case taskID = "taskId"
        case processDefinitionName, processDefinitionKey, tabs, fields, outcomes, javascriptEvents, className, style, customFieldTemplates, metadata, variables, customFieldsValueInfo, gridsterForm, globalDateFormat
        case taskName, taskDefinitionKey, selectedOutcome
    }
    
    init(id: Int, name: String, processDefinitionID: String, processDefinitionName: String, processDefinitionKey: String, taskID: String, taskName: String, taskDefinitionKey: String, tabs: [JSONAny], fields: [Field], outcomes: [Outcome], javascriptEvents: [JSONAny], selectedOutcome: String, className: String, style: String, customFieldTemplates: CustomFieldTemplates, metadata: CustomFieldTemplates, variables: [JSONAny], customFieldsValueInfo: CustomFieldTemplates, gridsterForm: Bool, globalDateFormat: String) {
        self.id = id
        self.name = name
        self.processDefinitionID = processDefinitionID
        self.processDefinitionName = processDefinitionName
        self.processDefinitionKey = processDefinitionKey
        self.taskID = taskID
        self.taskName = taskName
        self.taskDefinitionKey = taskDefinitionKey
        self.tabs = tabs
        self.fields = fields
        self.outcomes = outcomes
        self.javascriptEvents = javascriptEvents
        self.selectedOutcome = selectedOutcome
        self.className = className
        self.style = style
        self.customFieldTemplates = customFieldTemplates
        self.metadata = metadata
        self.variables = variables
        self.customFieldsValueInfo = customFieldsValueInfo
        self.gridsterForm = gridsterForm
        self.globalDateFormat = globalDateFormat
    }
}

// MARK: - CustomFieldTemplates
public class CustomFieldTemplates: Codable {

    init() {
    }
}

// MARK: - Field
public class Field: Codable {
    public let fieldType, id: String
    public let name: String?
    public let type: String
    public let value: ValueUnion?
    public let fieldRequired, readOnly, overrideID: Bool
    public let colspan: Int
    public let placeholder: String?
    public let minLength, maxLength: Int
    public let minValue, maxValue, regexPattern, optionType: JSONNull?
    public let hasEmptyValue: Bool?
    public let options: [Option]?
    public let restURL, restResponsePath, restIDProperty, restLabelProperty: JSONNull?
    public let tab, className, dateDisplayFormat: JSONNull?
    public let layout: Layout?
    public let sizeX, sizeY, row, col: Int
    public let visibilityCondition: JSONNull?
    public let numberOfColumns: Int?
    public let fields: [String: [Field]]?
    public let params: Params?
    public let metaDataColumnDefinitions, endpoint, requestHeaders: JSONNull?

    enum CodingKeys: String, CodingKey {
        case fieldType, id, name, type, value
        case fieldRequired = "required"
        case readOnly
        case overrideID = "overrideId"
        case colspan, placeholder, minLength, maxLength, minValue, maxValue, regexPattern, optionType, hasEmptyValue, options
        case restURL = "restUrl"
        case restResponsePath
        case restIDProperty = "restIdProperty"
        case restLabelProperty, tab, className, dateDisplayFormat, layout, sizeX, sizeY, row, col, visibilityCondition, numberOfColumns, fields, params, metaDataColumnDefinitions, endpoint, requestHeaders
    }

    init(fieldType: String, id: String, name: String?, type: String, value: ValueUnion?, fieldRequired: Bool, readOnly: Bool, overrideID: Bool, colspan: Int, placeholder: String?, minLength: Int, maxLength: Int, minValue: JSONNull?, maxValue: JSONNull?, regexPattern: JSONNull?, optionType: JSONNull?, hasEmptyValue: Bool?, options: [Option]?, restURL: JSONNull?, restResponsePath: JSONNull?, restIDProperty: JSONNull?, restLabelProperty: JSONNull?, tab: JSONNull?, className: JSONNull?, dateDisplayFormat: JSONNull?, layout: Layout?, sizeX: Int, sizeY: Int, row: Int, col: Int, visibilityCondition: JSONNull?, numberOfColumns: Int?, fields: [String: [Field]]?, params: Params?, metaDataColumnDefinitions: JSONNull?, endpoint: JSONNull?, requestHeaders: JSONNull?) {
        self.fieldType = fieldType
        self.id = id
        self.name = name
        self.type = type
        self.value = value
        self.fieldRequired = fieldRequired
        self.readOnly = readOnly
        self.overrideID = overrideID
        self.colspan = colspan
        self.placeholder = placeholder
        self.minLength = minLength
        self.maxLength = maxLength
        self.minValue = minValue
        self.maxValue = maxValue
        self.regexPattern = regexPattern
        self.optionType = optionType
        self.hasEmptyValue = hasEmptyValue
        self.options = options
        self.restURL = restURL
        self.restResponsePath = restResponsePath
        self.restIDProperty = restIDProperty
        self.restLabelProperty = restLabelProperty
        self.tab = tab
        self.className = className
        self.dateDisplayFormat = dateDisplayFormat
        self.layout = layout
        self.sizeX = sizeX
        self.sizeY = sizeY
        self.row = row
        self.col = col
        self.visibilityCondition = visibilityCondition
        self.numberOfColumns = numberOfColumns
        self.fields = fields
        self.params = params
        self.metaDataColumnDefinitions = metaDataColumnDefinitions
        self.endpoint = endpoint
        self.requestHeaders = requestHeaders
    }
}

// MARK: - Layout
public class Layout: Codable {
    public let row, column, colspan: Int

    public init(row: Int, column: Int, colspan: Int) {
        self.row = row
        self.column = column
        self.colspan = colspan
    }
}

// MARK: - Option
public class Option: Codable {
    public let id, name: String
    
    public init(id: String, name: String) {
        self.id = id
        self.name = name
    }
}

// MARK: - Params
public class Params: Codable {
    public let existingColspan, maxColspan: Int
    public let multiple: Bool?
    public let fileSource: FileSource?

    init(existingColspan: Int, maxColspan: Int, multiple: Bool?, fileSource: FileSource?) {
        self.existingColspan = existingColspan
        self.maxColspan = maxColspan
        self.multiple = multiple
        self.fileSource = fileSource
    }
}

// MARK: - FileSource
public class FileSource: Codable {
    public let serviceID, name: String

    enum CodingKeys: String, CodingKey {
        case serviceID = "serviceId"
        case name
    }

    public init(serviceID: String, name: String) {
        self.serviceID = serviceID
        self.name = name
    }
}

// MARK: - Encode/decode helpers

public class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(0)
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

public class JSONCodingKey: CodingKey {
    public let key: String

    public required init?(intValue: Int) {
        return nil
    }

    public required init?(stringValue: String) {
        key = stringValue
    }

    public var intValue: Int? {
        return nil
    }

    public var stringValue: String {
        return key
    }
}

public class JSONAny: Codable {

    public let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }

    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }

    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

public enum ValueUnion: Codable {
    case string(String)
    case valueElementArray([ValueElement])
    case null

    public func getStringValue() -> String? {
        switch self {
        case .string(let num):
            return num
        case .valueElementArray(let num):
            return nil
        case .null:
            return nil
        }
    }
    
    public func getArrayValue() -> [ValueElement]? {
        switch self {
        case .string(let num):
            return nil
        case .valueElementArray(let num):
            return num
        case .null:
            return nil
        }
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if let x = try? container.decode([ValueElement].self) {
            self = .valueElementArray(x)
            return
        }
        if let x = try? container.decode(String.self) {
            self = .string(x)
            return
        }
        if container.decodeNil() {
            self = .null
            return
        }
        throw DecodingError.typeMismatch(ValueUnion.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for ValueUnion"))
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        switch self {
        case .string(let x):
            try container.encode(x)
        case .valueElementArray(let x):
            try container.encode(x)
        case .null:
            try container.encodeNil()
        }
    }
}

// MARK: - ValueElement
public class ValueElement: Codable {
    public let id: Int
    public let name, created: String
    public let createdBy: CreatedBy
    public let relatedContent, contentAvailable, link: Bool
    public let mimeType, simpleType, previewStatus, thumbnailStatus: String

    init(id: Int, name: String, created: String, createdBy: CreatedBy, relatedContent: Bool, contentAvailable: Bool, link: Bool, mimeType: String, simpleType: String, previewStatus: String, thumbnailStatus: String) {
        self.id = id
        self.name = name
        self.created = created
        self.createdBy = createdBy
        self.relatedContent = relatedContent
        self.contentAvailable = contentAvailable
        self.link = link
        self.mimeType = mimeType
        self.simpleType = simpleType
        self.previewStatus = previewStatus
        self.thumbnailStatus = thumbnailStatus
    }
}

// MARK: - CreatedBy
public class CreatedBy: Codable {
    public let id: Int
    public let firstName, lastName, email: String

    init(id: Int, firstName: String, lastName: String, email: String) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}

// MARK: - Outcome
public class Outcome: Codable {
    public let id: JSONNull?
    public let name: String

    init(id: JSONNull?, name: String) {
        self.id = id
        self.name = name
    }
}
