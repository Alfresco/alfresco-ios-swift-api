
# Alfresco Swift clients

## Overview
This is the Swift native client library project for Alfresco services which allows developers to leverage the power of the Digital Business Platform within their native Swift / Obj-C apps or frameworks. 

## Prerequisites
The preferred method for delivery of the frameworks is Cocoapods. Carthage integration is currently unsupported.

## Requirements
* iOS 12.0 + / macOS 10.14+ / tvOS 12.0+
* Swift 5.0+

## Installation 
Using Cocoapods dependency manager you can integrate one of the Alfresco clients into your XCode project by specifying it in your `Podfile`:

    pod 'AlfrescoContentServicesCore'
    pod 'AlfrescoSearchServices'

For more details on how to set up Cocoapods, please refer to the [official documentation](https://cocoapods.org/).

## Getting Started
To start using the modules you will first need to import them in your business logic layer then set the `basePath` static property on each of the imported modules to point to the correct instance of Alfresco. Additionally, you should provide a credential set which you could either attach as part of the `customHeaders` property or use the `credential: URLCredential?` property. 

Based on the credential type, BasicAuth or AIMS, the dictionary pair may vary (BasicAuth is used for the current example). 

An example for fetching a list of sites using the `content-services-core` library would look like this:

    import AlfrescoContentServicesCore
    
    class YourBusinessLayer {
	    func requestSites() {
		    AlfrescoContentServicesCoreAPI.basePath = "https://api-explorer.alfresco.com/alfresco/api/-default-/public/alfresco/versions/1"
		    AlfrescoContentServicesCoreAPI.customHeaders = ["Authorization" : "<CredentialValueHere>"]
		    SitesAPI.listSites { (paging, error) in
			    // Handle response
		    }
	    }
    }

## Documentation
The library documentation is generated based on the OpenAPI specification of the actual endpoints described within the Swagger YAML files. However, a more dynamic version of that can also be accessed as part of [Alfresco's API Explorer](https://api-explorer.alfresco.com/api-explorer/). 
 ## License
 Alfresco Swift Swagger client library is released under the Apache 2.0 license. For more details please check the license files under each of the libraries.