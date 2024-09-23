//
//  MobileConfigData.swift
//  AlfrescoContent
//
//  Created by Vinay Piplani on 11/09/24.
//

import Foundation

// Enum for menu IDs
public enum MenuId: String, Codable {
    case addFavorite = "app.menu.addFavourite"
    case removeFavorite = "app.menu.removeFavourite"
    case rename = "app.menu.rename"
    case move = "app.menu.move"
    case openWith = "app.menu.openWith"
    case download = "app.menu.download"
    case trash = "app.menu.trash"
    case addOffline = "app.menu.addOffline"
    case removeOffline = "app.menu.removeOffline"
    case restore = "app.menu.restore"
    case permanentlyDelete = "app.menu.permanentlyDelete"
    case startProcess = "app.menu.startProcess"
    
    // Fallback for unknown values
    case unknown

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let rawValue = try container.decode(String.self)
        self = MenuId(rawValue: rawValue) ?? .unknown
    }
}

// MARK: - AppConfig
public struct MobileConfigData: Codable {
    public let featuresMobile: Features

    public enum CodingKeys: String, CodingKey {
        case featuresMobile = "features_mobile"
    }
}

// MARK: - Features
public struct Features: Codable {
    public let menu: [Menu]
}

// MARK: - DynamicMenu
public struct Menu: Codable {
    public let id: MenuId
    public let enabled: Bool
}
