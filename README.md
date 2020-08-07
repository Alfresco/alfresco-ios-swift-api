# <img title="Alfresco" alt='Alfresco' src='docs/logo.svg' height="32px" /> iOS Swift API

Support libraries which enable easier development of iOS applications that work with Alfresco products.

## Installation
The libraries are available as independent frameworks via Cocoapods. Currently they are distributed as [private pods](https://guides.cocoapods.org/making/private-cocoapods.html) and are in-house hosted at [https://github.com/Alfresco/alfresco-private-podspecs-ios-sdk](https://github.com/Alfresco/alfresco-private-podspecs-ios-sdk). Future plans include migration to the Cocoapods official repository.

To install them you first need to add our own private pods repo (**step also needed to run the [Sample App](https://github.com/Alfresco/alfresco-ios-swift-api/tree/develop/SampleApp)**):

    pod repo add AlfrescoPodspec https://github.com/Alfresco/alfresco-private-podspecs-ios-sdk

Then, head over to project folder, create a pod file by issuing `pod init` into the terminal, edit it and add the following:
```
source 'https://github.com/Alfresco/alfresco-private-podspecs-ios-sdk.git'
source 'https://github.com/CocoaPods/Specs.git'
```
followed by your desired pod configuration. 
E.g.  :
`pod 'AlfrescoAuth'`
`pod 'AlfrescoContentServices'`

For more details on how to set up Cocoapods, please refer to the  [official documentation](https://cocoapods.org/).

The libraries require **iOS 12**+ and **Swift 5**+.

## Getting started

Easiest way to get off the ground is to check the included  [Sample App](https://github.com/Alfresco/alfresco-ios-swift-api/tree/develop/SampleApp).

The sample shows how to get authentication working with the identity service, and how to integrate that with the API bindings to get a first request going.

The app should just work with your identity service install, but might not match your current configuration so edit [AuthenticationParameters.swift](https://github.com/Alfresco/alfresco-ios-swift-api/blob/develop/SampleApp/SampleApp/Authentication/Model/AuthenticationParameters.swift) if you run into any issues. 

## Authentication

The **auth** module offers several abstractions to work with the Alfresco Identity Service and Basic Authentication.

### Basic Authentication

For basic authentication build your own UI to collect credentials. There isn't much to provide to the library but you could take advantage of some of the constructs we've been using in the [sample app](https://github.com/Alfresco/alfresco-ios-swift-api/blob/a9e97911afe9ad9f79313d25c12bcadec86c9a4c/SampleApp/SampleApp/Authentication/Services/AuthenticationService.swift#L81).

### SSO Authentication

For SSO your activity will have to present the user a WebView for him to login and then collect the token at the end.

Several steps are required to make it work.

##### Registering a mobile clientID in Keycloak 

*Note that this step is optional as it might have been taken care of by your administrator.*

First, you need to define a client within Identity service that would serve the mobile apps. Access Keycloak admin interface and navigate to the Clients page. Add a new client entry and note down the client ID value. Save the entry and on the next page, search for the  `Valid Redirect URIs`  field. The value for this particular field should be in the following format  `clientID://custom-domain-name/auth`.

##### Register the redirect URI with your mobile app

It's important that the redirect URI that was set is mirrored in the settings of the mobile client as well. To do so, open up the  `Info.plist`  file of your project, and add the following structure:
-   Add a 'URL types' key of type Array
-   As a child dependency for 'URL types' add a new key of type Dictionary
-   As a child dependency of the former item, add a 'URL Schemes' key of type String with the value of the previously set redirect URI.

For more information, please refer to our  [sample app](https://github.com/Alfresco/alfresco-ios-swift-api/tree/develop/SampleApp).

##### Call the AlfrescoAuth API

First, your view model will have to initialize the auth module with your configuration and call the authentication method. The configuration object needs to match your configuration in Identity Service.

```swift
class MyLoginViewModel {
  init() {
    alfrescoAuth = AlfrescoAuth.init(configuration: authConfig)
  }
  ...
}
```
Next call the **pkceAuth** method on the auth module passing in the view controller where you want to show the SSO Webview and delegate class where to receive the updates.
```swift
class  MyLoginViewModel {
  func login(in viewController: UIViewController) {
    alfrescoAuth.pkceAuth(onViewController: viewController, delegate: self)
  }
}

extension MyLoginViewModel: AlfrescoAuthDelegate {
  func didReceive(result: Result<AlfrescoCredential, APIError>, session: AlfrescoAuthSession?) {
    switch result {
      case.success(let credential):
        // Store credential and session object
	...
      case .failure(let error):
        ...
    }
}
```
Upon successful login the server will callback with your token using the callback URI in your `Info.plist`.

The authorization response URL is returned to the app via the  `- (**BOOL**)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, **id**> *)options`  app delegate method so you need to pipe this through the current authorization session.

On the  `AlfrescoSession`  object call the  `resumeExternalUserAgentFlow`  method and forward the URL provided by the openURL method.

You can check out our sample app to see [a way of handling this](https://github.com/Alfresco/alfresco-ios-swift-api/blob/a9e97911afe9ad9f79313d25c12bcadec86c9a4c/SampleApp/SampleApp/Authentication/Services/AuthenticationService.swift#L109).

### After Authentication

Because authentication is an independent step we  **strongly**  recommend you do extra validation after  **didReceive**  before letting the user into the app.

Things you could check at this time, could be profile information or permissions, which would require calling the Alfresco service and thus verifying your authentication session is working correctly.

##### Keeping the session object alive

Depending of the desired mode of authentication, the session object might need to be kept alive in the object graph. This is valid for the PKCE mode of authentication. 

Upon authentication, the AlfrescoAuth module will provide an  `AlfrescoSession`  object that should be referenced for the timespan of the session is active. This is the only object that you need to serialize to retain the authorization state.

### Logging out

While normally you could just destroy the persisted credentials, in case of SSO the session needs to be invalidated or the user will log back in without a credentials prompt.

To do so, just call the logout method on the AlfrescoAuth module providing the last set of credentials you have for the user.

```swift
class  MyLoginViewModel {
  func logOut(onViewController viewController: UIViewController, lastKnownCredential: AlfrescoCredential, delegate: AlfrescoAuthDelegate) {
    alfrescoAuth.logout(onViewController: viewController, delegate: self, forCredential: lastKnownCredential)
  }
}

extension MyLoginViewModel: AlfrescoAuthDelegate {
  func didLogOut(result: Result<Int, APIError>) {
    ...
  }
}
```

### Re-authenticating

In the case of SSO the refresh token might expire or a remote actor might invalidate the user's session in the Identity Service.

Even in the Basic Authentication scenario this may happen if the password gets changed.

When this happens  we recommend you prompt the user that he'll have to re-login.

While for Basic Authentication it's up to you to figure out the integration, for SSO there is a special re-authentication flow.

```swift
class  MyLoginViewModel {
  func refreshSession(delegate: AlfrescoAuthDelegate) {
    // The session object is the same one provided after the successfull log in
    if let session = self.session {  
      alfrescoAuth.pkceRefresh(session: session, delegate: self)
    }
  }
}
```

On success the new session will be returned again via `didReceive(result:, session:)` and after updating the stored credentials you can let the user resume their activities.

## Content Services API

The  **content**  module provides API bindings to be used with  [Alfresco Content Services](https://api-explorer.alfresco.com/)

The module includes bindings for both  **search**  and  **core**  to make it easier to integrate in most applications.

To start using the module you will first need to import it in your business logic layer then set the `basePath` static property to point to the correct instance of Alfresco. 

Additionally, you should provide a credential set which you could either attach as part of the `customHeaders` property or use the `credential: URLCredential?` property.

Now just get a service and make your request:
```swift
class RecentsViewModel {
  func fetchRecentsList() {
    AlfrescoContentAPI.customHeaders = ["Authorization": authorizationHeaderValue()]
    SearchAPI.search(queryBody:"my querry", ...) {
      if let entries = result?.list?.entries {
        // handle results
      }
    }
  }
}
```

For more information on the APIs just read our  [documentation](https://api-explorer.alfresco.com/)

## Development

We'd love to accept your patches and contributions to this project.

## Code reviews

All external submissions require formal review. We use GitHub pull requests for this purpose. Consult  [GitHub Help](https://help.github.com/articles/about-pull-requests/)  for more information on using pull requests.
