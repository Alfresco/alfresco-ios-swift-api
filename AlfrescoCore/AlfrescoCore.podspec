Pod::Spec.new do |s|

s.name                  = 'AlfrescoCore'
s.version               = '0.1.1'
s.summary               = 'This is Alfresco Core module.'
s.homepage              = 'http://alfresco-identity-service.mobile.dev.alfresco.me'
# 'https://github.com/Alfresco/ios-dbp-sdk'
s.author                = {'Alfresco' => 'mobile.alfresco@alfresco.com' }
s.license				= {:type => 'Apache License Version 2.0', :file => 'AlfrescoCore/LICENSE.md'} 
s.source                = {:git => 'https://github.com/Alfresco/ios-dbp-sdk.git', :tag => 'core/0.1.1'}
s.source_files 			= 'AlfrescoCore/Sources/**/*.{swift}'
s.exclude_files			= ['AlfrescoCore/AlfrescoCoreTests', 'AlfrescoCore/Sources/**/*.plist']
s.ios.deployment_target = '12.0'
s.swift_version         = '5.0'
# s.framework 			= 'XCTest'

end
