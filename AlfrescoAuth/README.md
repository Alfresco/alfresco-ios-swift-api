# Alfresco Auth Module

To correctly set up the Auth module the adopter must comply to a set of configuration steps. Primarily these steps are intended to create a correlation between Identity service and the mobile client configurations. 

## Registering a mobile clientID in Keycloak

First, we need to define a client within Identity service that would serve the mobile apps. Access Keycloak admin interface and navigate to the Clients page. Add a new client entry and mark down the client ID value. Save the entry and on the next page, search for the `Valid Redirect URIs` field. The value for this particular field should be in the following format `clientID://custom-domain-name/auth`.  

It's important that the clientID that was set is mirrored in the settings of the mobile client as well. To do so, open up the `Info.plist` file of your project, and add the following structure:
- Add a 'URL types' key of type Array
- As a child dependency for 'URL types' add a new key of type Dictionary
- As a child dependency of the former item, add a 'URL Schemes' key of type String with the value of the previously set clientID.

For more information, please refer to our [sample app](https://github.com/Alfresco/ios-dbp-sample-app).

## Keeping the session object alive
Depending of the desired mode of authentication, the session object might need to be kept alive in the object graph. This is valid for the PKCE mode of authentication. Upon authentication, the AlfrescoAuth module will provide an `AlfrescoSession` object that should be referenced for the timespan of the session is active. This is the only object that you need to serialize to retain the authorization state. 

## Handling redirects
When using the PKCE authentication method, the authorization response URL is returned to the app via the
 `- (**BOOL**)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<UIApplicationOpenURLOptionsKey, **id**> *)options`  app delegate method so you need to pipe this through the current authorization session. 

On the `AlfrescoSession` object call the `resumeExternalUserAgentFlow` method and forward the URL provided by the openURL method.