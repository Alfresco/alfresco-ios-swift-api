Pod::Spec.new do |s|

s.name                  = 'AlfrescoCore'
s.version               = '0.1.2'
s.summary               = 'Alfresco Core iOS Swift API'
s.homepage              = 'https://github.com/Alfresco/alfresco-ios-swift-api'
s.author                = {'Alfresco' => 'mobile.alfresco@alfresco.com' }
s.license				= {:type => 'Apache License Version 2.0', :file => 'AlfrescoCore/LICENSE.md'} 
s.source                = {:git => 'https://github.com/Alfresco/alfresco-ios-swift-api.git', :tag => 'core/'+s.version.to_s}
s.source_files 			= 'AlfrescoCore/Sources/**/*.{swift}'
s.exclude_files			= ['AlfrescoCore/AlfrescoCoreTests', 'AlfrescoCore/Sources/**/*.plist']
s.ios.deployment_target = '12.0'
s.swift_version         = '5.0'
# s.framework 			= 'XCTest'

end
