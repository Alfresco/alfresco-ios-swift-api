Pod::Spec.new do |s|
  s.name = 'AlfrescoContentServices'
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.14'
  s.tvos.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.version = '0.0.2'
  s.source = {:git => 'https://github.com/Alfresco/ios-dbp-sdk', :tag => 'content-services/'+s.version.to_s}
  s.authors = '{&#39;Alfresco&#39; &#x3D;&gt; &#39;mobile.alfresco@alfresco.com&#39;}'
  s.license = {:type => 'Apache License Version 2.0', :file => 'AlfrescoContentServices/LICENSE.md'}
  s.homepage = 'https://github.com/Alfresco/ios-dbp-sdk'
  s.summary = 'Alfresco Content Services module'
  s.source_files = 'AlfrescoContentServices/**/*'
  s.exclude_files = ['AlfrescoContentServices/template', 'AlfrescoContentServices/AlfrescoContentServicesSwaggerConfiguration.json']
  s.dependency 'Alamofire', '~> 4.9.0'
end
