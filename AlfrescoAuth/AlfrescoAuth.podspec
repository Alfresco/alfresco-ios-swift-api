Pod::Spec.new do |s|

s.name                  = 'AlfrescoAuth'
s.version               = '0.2.0-alpha.1'
s.summary               = 'Alfresco Auth iOS Swift API'
s.homepage              = 'https://github.com/Alfresco/alfresco-ios-swift-api'
s.author                = {'Alfresco' => 'mobile.alfresco@alfresco.com' }
s.license				= {:type => 'Apache License Version 2.0', :file => 'AlfrescoAuth/LICENSE.md'} 
s.source                = {:git => 'https://github.com/Alfresco/alfresco-ios-swift-api.git', :tag => 'auth/'+s.version.to_s}
s.source_files 			= 'AlfrescoAuth/Sources/**/*.{swift,h,m}'
s.exclude_files			= ['AlfrescoAuth/AlfrescoAuthTests', 'AlfrescoAuth/Sources/**/*.plist']
s.ios.deployment_target = '12.0'
s.swift_version         = '5.0'
s.framework 			= ['WebKit']
s.resources 			= ["AlfrescoAuth/Sources/**/*.storyboard"]
s.dependency 			 'AlfrescoCore'
s.dependency 			 'AppAuth'
s.dependency 			 'Auth0'

end