//
//  ProcessSystemProperties.swift
//  AlfrescoContent
//
//  Created by Ankit Goyal on 31/03/23.
//

import Foundation

// MARK: Process System properties
public class ProcessSystemProperties: Codable {
    public var allowInvolveByEmail: Bool?
    public var disableJavaScriptEventsInFormEditor: Bool?
    public var logoutDisabled: Bool?
    public var alfrescoContentSsoEnabled: Bool?
    public var authConfiguration: AuthConfiguration?
}

public class AuthConfiguration: Codable {
    public var authUrl: String?
    public var realm: String?
    public var clientId: String?
    public var useBrowserLogout: Bool?

}
