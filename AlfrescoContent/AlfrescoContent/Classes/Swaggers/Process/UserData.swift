//
//  UserData.swift
//  AlfrescoContent
//
//  Created by global on 12/09/22.
//

import Foundation

// MARK: User data
public class UserData: Codable {
    public var id: Int?
    public var firstName: String?
    public var lastName: String?
    public var email: String?
    public var pictureId: String?
    public var fullname: String?
    public var type: String?
    public var status: String?
}
