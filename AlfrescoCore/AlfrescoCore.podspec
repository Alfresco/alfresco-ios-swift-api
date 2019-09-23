Pod::Spec.new do |s|

s.name                  = 'AlfrescoCore'
s.version               = '0.1.0'
s.summary               = 'This is Alfresco Core module.'
s.homepage              = 'https://github.com/Alfresco/ios-dbp-sdk'
s.author                = {'Alfresco' => 'mobile.alfresco@alfresco.com' }
s.license				= {:type => 'APACHE 2.0', :file => 'LICENSE'}
s.source                = {:git => 'https://github.com/Alfresco/ios-dbp-sdk.git', :tag => 'core/0.1.0'}
s.source_files 			= "AlfrescoCore/**/*.{swift}"
s.ios.deployment_target = '12.0'
s.swift_version         = '5.0'

end
