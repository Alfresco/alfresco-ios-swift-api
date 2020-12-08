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

import UIKit
import AlfrescoCore

/// Delegate of the AlfrescoAuth module used to monitor responses coming from the Identity Service.
public protocol AlfrescoAuthDelegate: class {

    /** Called when a response coming from the Identity Service is available.
     - Parameter result: Convenience object containing token related information  used to authorize further requests or
                         an optional error parameter.
     - Parameter session:Optional session object relevant to PKCE authentication type containing token related
                         information which must be serialized in order to restore session information at a later
                         point. Properties of object implement NSSecureCoding
    */
    func didReceive(result: Result<AlfrescoCredential?, APIError>, session: AlfrescoAuthSession?)

    /** Called when a response coming from the identity Service is available as a result to a logout request.
    - Parameter result: Status code for the logout request or an optional error parameter.
     */
    func didLogOut(result: Result<Int, APIError>, session: AlfrescoAuthSession?)
}

extension AlfrescoAuthDelegate {
    func didReceive(result: Result<AlfrescoCredential?, APIError>,
                    session: AlfrescoAuthSession? = nil) {
        didReceive(result: result, session: session)
    }

    func didLogOut(result: Result<Int, APIError>, session: AlfrescoAuthSession? = nil) {
        didLogOut(result: result, session: session)
    }
}

public struct AlfrescoAuth {
    // Presenters
    var webPresenter: AuthWebPresenter?
    var basicPresenter: AuthBasicPresenter?
    var refreshPresenter: RefreshTokenPresenter?
    var pkcePresenter: AuthPkcePresenter?

    // Configuration
    var configuration: AuthConfiguration

    /** Designated initializer of the AlfrescoAuthModule.
    - Parameter configuration: Identity Service related configuration parameters.
    */
    public init(configuration: AuthConfiguration) {
        self.configuration = configuration
    }

    /** Convenience method to update the configuration of the AlfrescoAuthModule
    - Parameter configuration: Identity Service related configuration parameters.
     */
    public mutating func update(configuration: AuthConfiguration) {
        self.configuration = configuration
    }

    /** Alternative method used to authenticate with Identity Service when it is set up to work with an exernal provider
     that invokes the use of web view components.
    - Parameter alfrescoAuthDelegate: Delegate used to report the state and response of the authentication request
    */
    public mutating func webAuth(delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) -> UIViewController? {
        webPresenter = AuthWebPresenter(configuration: configuration)
        webPresenter?.authDelegate = alfrescoAuthDelegate

        let frameworkBundle = Bundle(for: AuthWebViewController.self)
        let storyboard = UIStoryboard(name: "Auth", bundle: frameworkBundle)
        let identifier = String(describing: AuthWebViewController.self)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier) as? AuthWebViewController

        controller?.presenter = webPresenter
        controller?.urlString = String(format: kWebSAMLURLString,
                                      configuration.baseUrl,
                                      configuration.realm)

        return controller
    }

    /** Alternative method used to authenticate with Identity Service when it is set up to work with Basic Auth.
    - Parameter username: Username for which the authentication request is created
    - Parameter password: Password for which the authentication request is created
    - Parameter alfrescoAuthDelegate: Delegate used to report the state and response of the authentication request
    */
    public mutating func basicAuth(username: String?,
                                   password: String?,
                                   delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        basicPresenter = AuthBasicPresenter(configuration: configuration)
        basicPresenter?.authDelegate = alfrescoAuthDelegate
        basicPresenter?.execute(username: username, password: password)
    }

    /** Alternative method used to refresh session with Identity service.
    - Remark: Works with all the provided authentication methods in AlfrescoAuth
    - Parameter credential: Object containing token related information
    - Parameter alfrescoAuthDelegate: Delegate used to report the state and response of the authentication request
    */
    public mutating func refreshSession(credential: AlfrescoCredential,
                                        delegate alfrescoAuthDelegate: AlfrescoAuthDelegate) {
        refreshPresenter = RefreshTokenPresenter(configuration: configuration)
        refreshPresenter?.authDelegate = alfrescoAuthDelegate
        refreshPresenter?.executeRefresh(credential)
    }

    /** Designated safe authetication method with Identity Service using PKCE protocol.
    - Parameter viewController: Thew view controller from which to present the SFSafariViewController.
    - Parameter delegate: Delegate used to report the state and response of the authentication request
    */
    public mutating func pkceAuth(onViewController viewController: UIViewController,
                                  delegate: AlfrescoAuthDelegate) {
        pkcePresenter = AuthPkcePresenter(configuration: configuration)
        pkcePresenter?.presentingViewController = viewController
        pkcePresenter?.authDelegate = delegate
        pkcePresenter?.authSession = AlfrescoAuthSession()
        pkcePresenter?.execute()
    }

    /** Given a module configuration,  it returns via a closure the available authentication type for the base URL
     defined in the AlfrescoConfiguration object.
    - Parameter handler: Closure delivering updates on the authentication type. Possible values are base auth,
     AIMS and an optional error
     */
    public mutating func availableAuthType(handler:@escaping ((Result<AvailableAuthType, APIError>) -> Void)) {
        pkcePresenter = AuthPkcePresenter(configuration: configuration)
        pkcePresenter?.availableAuthType(handler: { result in
            handler(result)
        })
    }

    /** Designated safe session refresh method with Identity Service  using PKCE protocol.
    - Parameter delegate: Delegate used to report the state and response of the re-authentication request
    - Parameter session: Valid session object that was created as a result of a successfull PKCE authentication.
     */
    public mutating func pkceRefresh(session: AlfrescoAuthSession,
                                     delegate: AlfrescoAuthDelegate) {
        pkcePresenter = AuthPkcePresenter(configuration: configuration)
        pkcePresenter?.authSession = session
        pkcePresenter?.authDelegate = delegate
        pkcePresenter?.executeRefreshSession()
    }

    /** Logs out the user  by expiring the refresh token for the current auth configuration.
    - Remark:the access token remains valid for it's designated lifespan, but the next time a request to refresh
             the session it is received the server will refuse and return a 401 Unauthorised response.
             Starting with iOS 12 and up, cookies are no longer reliably shared with developers and as a
             workaround the logout request will take place under the same session they have been created
             in the first place. To that end, a ASWebAuthenticationSession object will be used to run the
             logout request, thus deleting the remaining cookies.
    - Parameter viewController: View controller on which to present the logout web view component
    - Parameter delegate: Delegate used to report the state of the logout request.
    - Parameter session: Valid session object that was created as a result of a successfull PKCE authentication.
    - Parameter credential: Alfresco credential for which the logout is requested
     */
    public mutating func logout(onViewController viewController: UIViewController,
                                delegate: AlfrescoAuthDelegate,
                                session: AlfrescoAuthSession,
                                forCredential credential: AlfrescoCredential) {
        pkcePresenter = AuthPkcePresenter(configuration: configuration)
        pkcePresenter?.authSession = session
        pkcePresenter?.presentingViewController = viewController
        pkcePresenter?.authDelegate = delegate
        pkcePresenter?.logout(forCredential: credential)
    }
}
