# Generates Swift API bindings using the merged definitions of Auth, Core and Search APIs whilst decorating the podspec file
echo "Generating AlfrescoContent library from API specification"
swagger-codegen generate -i definitions/merged.yaml -l swift5 -c ./AlfrescoContentSwaggerConfiguration.json -o . -t ./template --type-mappings file=Data 2>log.txt

echo "Customizing library with extensions"
# Copy additional extensions to augment the generated library
cp extensions/APIs/* AlfrescoContent/Classes/Swaggers/APIs