Pod::Spec.new do |s|
  s.name = 'AlfrescoContent'
  s.ios.deployment_target = '12.0'
  s.osx.deployment_target = '10.14'
  s.tvos.deployment_target = '12.0'
  s.swift_version = '5.0'
  s.version = '0.1.2'
  s.source = {:git => 'https://github.com/Alfresco/alfresco-ios-swift-api.git', :tag => 'content/'+s.version.to_s}
  s.authors = {'Alfresco' => 'mobile.alfresco@alfresco.com' }
  s.license = {:type => 'Apache License Version 2.0', :file => 'AlfrescoContent/LICENSE.md'}
  s.homepage = 'https://github.com/Alfresco/alfresco-ios-swift-api'
  s.summary = 'Alfresco Content iOS Swift API'
  s.source_files = 'AlfrescoContent/**/*'
  s.exclude_files = ['AlfrescoContent/template', 'AlfrescoContent/AlfrescoContentSwaggerConfiguration.json', 'AlfrescoContent/definitions', 'AlfrescoContent/AlfrescoContent.podspec', 'AlfrescoContent/azure-pipelines.yml', 'AlfrescoContent/Cartfile', 'AlfrescoContent/LICENSE.md', 'AlfrescoContent/generateLibrary.sh']
  s.dependency 'Alamofire', '~> 4.9.0'
end
