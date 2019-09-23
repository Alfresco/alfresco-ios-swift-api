Pod::Spec.new do |s|

s.name                  = 'AlfrescoCore'
s.version               = '0.1.1'
s.summary               = 'This is Alfresco Core module.'
s.homepage              = 'https://github.com/Alfresco/ios-dbp-sdk'
s.author                = {'Alfresco' => 'mobile.alfresco@alfresco.com' }
s.license				= {:type => 'Apache License Version 2.0', :text => 'This is not a License file.'}
s.source                = {:git => 'https://github.com/Alfresco/ios-dbp-sdk.git', :tag => 'core/0.1.1'}
s.source_files 			= 'Sources/**/*'
s.exclude_files			= ['AlfrescoCoreTests', 'Sources/**/*.plist']
s.ios.deployment_target = '12.0'
s.swift_version         = '5.0'
s.framework 			= 'XCTest'

end
