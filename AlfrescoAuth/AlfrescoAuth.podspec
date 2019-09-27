Pod::Spec.new do |s|

s.name                  = 'AlfrescoAuth'
s.version               = '0.1.0'
s.summary               = 'Alfresco DBP SDK Auth module'
s.homepage              = 'http://alfresco-identity-service.mobile.dev.alfresco.me'
# 'https://github.com/Alfresco/ios-dbp-sdk'
s.author                = {'Alfresco' => 'mobile.alfresco@alfresco.com' }
s.license				= {:type => 'Apache License Version 2.0', :file => 'AlfrescoAuth/LICENSE.md'} 
s.source                = {:git => 'https://github.com/Alfresco/ios-dbp-sdk.git', :tag => 'auth/'+s.version.to_s}
s.source_files 			= 'AlfrescoAuth/Sources/**/*.{swift}'
s.exclude_files			= ['AlfrescoAuth/AlfrescoAuthTests', 'AlfrescoAuth/Sources/**/*.plist']
s.ios.deployment_target = '12.0'
s.swift_version         = '5.0'
s.framework 			= ['WebKit']
s.resources 			= ["Sources/**/*.storyboard"]
s.dependency 			 'AlfrescoCore'

end