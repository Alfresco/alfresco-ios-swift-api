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

public enum StatusCodes: Int {

    // Informational
    case code100Continue = 100
    case code101SwitchingProtocols = 101
    case code102Processing = 102

    // Success
    case code200OK = 200
    case code201Created = 201
    case code202Accepted = 202
    case code203NonAuthoritativeInformation = 203
    case code204NoContent = 204
    case code205ResetContent = 205
    case code206PartialContent = 206
    case code207MultiStatus = 207
    case code208AlreadyReported = 208
    case code209IMUsed = 209

    // Redirection
    case code300MultipleChoices = 300
    case code301MovedPermanently = 301
    case code302Found = 302
    case code303SeeOther = 303
    case code304NotModified = 304
    case code305UseProxy = 305
    case code306SwitchProxy = 306
    case code307TemporaryRedirect = 307
    case code308PermanentRedirect = 308

    // Client error
    case code400BadRequest = 400
    case code401Unauthorised = 401
    case code402PaymentRequired = 402
    case code403Forbidden = 403
    case code404NotFound = 404
    case code405MethodNotAllowed = 405
    case code406NotAcceptable = 406
    case code407ProxyAuthenticationRequired = 407
    case code408RequestTimeout = 408
    case code409Conflict = 409
    case code410Gone = 410
    case code411LengthRequired = 411
    case code412PreconditionFailed = 412
    case code413RequestEntityTooLarge = 413
    case code414RequestURITooLong = 414
    case code415UnsupportedMediaType = 415
    case code416RequestedRangeNotSatisfiable = 416
    case code417ExpectationFailed = 417
    case code418IamATeapot = 418
    case code419AuthenticationTimeout = 419
    case code420MethodFailureSpringFramework = 420
    case code420EnhanceYourCalmTwitter = 4200
    case code422UnprocessableEntity = 422
    case code423Locked = 423
    case code424FailedDependency = 424
    case code424MethodFailureWebDaw = 4240
    case code425UnorderedCollection = 425
    case code426UpgradeRequired = 426
    case code428PreconditionRequired = 428
    case code429TooManyRequests = 429
    case code431RequestHeaderFieldsTooLarge = 431
    case code444NoResponseNginx = 444
    case code449RetryWithMicrosoft = 449
    case code450BlockedByWindowsParentalControls = 450
    case code451RedirectMicrosoft = 451
    case code451UnavailableForLegalReasons = 4510
    case code494RequestHeaderTooLargeNginx = 494
    case code495CertErrorNginx = 495
    case code496NoCertNginx = 496
    case code497HTTPToHTTPSNginx = 497
    case code499ClientClosedRequestNginx = 499

    // Server error
    case code500InternalServerError = 500
    case code501NotImplemented = 501
    case code502BadGateway = 502
    case code503ServiceUnavailable = 503
    case code504GatewayTimeout = 504
    case code505HTTPVersionNotSupported = 505
    case code506VariantAlsoNegotiates = 506
    case code507InsufficientStorage = 507
    case code508LoopDetected = 508
    case code509BandwidthLimitExceeded = 509
    case code510NotExtended = 510
    case code511NetworkAuthenticationRequired = 511
    case code522ConnectionTimedOut = 522
    case code598NetworkReadTimeoutErrorUnknown = 598
    case code599NetworkConnectTimeoutErrorUnknown = 599

    public var code: Int {
        return rawValue
    }
}
