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

// Error messages

let errorDataTaskResultNil = "DataTaskResult has nil parameters."
let errorResponseConvertToDictionary = "Data error response failed to convert into Dictionary."
let errorRequestUnavailable = "URLRequest has failed to be created."

// Module Error Type

public enum ModuleErrorType: Int {
    case errorDataTaskResultNil = 1000
    case errorResponseConvertToDictionary = 1001
    case errorRequestUnavailable = 1002

    public var code: Int {
        return rawValue
    }
}
