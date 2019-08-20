//
//  String+Helpers.swift
//  AlfrescoAuth
//
//  Created by Silviu Odobescu on 20/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

extension String {
    func replaceHashTagWithQuestionMark() -> String {
        return self.replacingOccurrences(of: "#", with: "?")
    }
}
