//
//  TestData.swift
//  AlfrescoAuthTests
//
//  Created by Silviu Odobescu on 05/08/2019.
//  Copyright © 2019 Alfresco. All rights reserved.
//

import Foundation

struct TestData {
    static let urlStringToLoadGood = "http://alfresco-identity-service.mobile.dev.alfresco.me/auth/?session_state=1a1cc1fc-e4d1-4430-8ff1-91ba7b7bff6e&code=6e5fc8c3-1be9-48f2-a15b-2f1e3388bf9a.1a1cc1fc-e4d1-4430-8ff1-91ba7b7bff6e.be13165d-2792-43aa-abdb-2c6cdb627184"
    static let urlStringWithoutCode = "http://alfresco-identity-service.mobile.dev.alfresco.me/auth/?session_state=12a79f9d-0531-4fb5-97f1-bd75508781a8&scope=profile"
    
    static let username1 = "admin"
    static let password1 = "admin"
    static let password2 = "admins"
    
    static let errorMessage1 = "This is an error!"
    
    static let code = "f744e33b-2ac8-47fd-9e3d-67de1b920ea3.87f5ebc0-b932-4503-9574-4b7eed086327.be13165d-2792-43aa-abdb-2c6cdb627184"
    static let accessTokenGood = "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI4eGoyekZmTDU0VFNRS2FwNUREOHVaUFpjTjN3VkxhaV9Jb0k2bGdaU2JBIn0.eyJqdGkiOiJlNjU3NTY4MC1mZDgzLTRiM2QtYmM5MS03MWU0NTQ3MDJkMzIiLCJleHAiOjE1Njc2NjcxNjMsIm5iZiI6MCwiaWF0IjoxNTY3NjY2ODYzLCJpc3MiOiJodHRwOi8vYWxmcmVzY28taWRlbnRpdHktc2VydmljZS5tb2JpbGUuZGV2LmFsZnJlc2NvLm1lL2F1dGgvcmVhbG1zL2FsZnJlc2NvIiwiYXVkIjpbInJlYWxtLW1hbmFnZW1lbnQiLCJhY2NvdW50Il0sInN1YiI6IjYwYTliNmM1LTY0ZWYtNDA1Zi04YzZmLTY2YmQ4Y2QzODc4YSIsInR5cCI6IkJlYXJlciIsImF6cCI6ImFsZnJlc2NvIiwiYXV0aF90aW1lIjowLCJzZXNzaW9uX3N0YXRlIjoiMjFkMzQ1OWUtOWQ3NC00YWNmLTk1MTMtNmIxYzA3MGE5MDczIiwiYWNyIjoiMSIsImFsbG93ZWQtb3JpZ2lucyI6WyIqIl0sInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJBQ1RJVklUSV9NT0RFTEVSIiwib2ZmbGluZV9hY2Nlc3MiLCJBQ1RJVklUSV9BRE1JTiIsIkFDVElWSVRJX1VTRVIiLCJ1bWFfYXV0aG9yaXphdGlvbiIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJyZWFsbS1tYW5hZ2VtZW50Ijp7InJvbGVzIjpbInZpZXctcmVhbG0iLCJtYW5hZ2UtcmVhbG0iLCJtYW5hZ2UtdXNlcnMiLCJ2aWV3LXVzZXJzIiwidmlldy1jbGllbnRzIiwicXVlcnktY2xpZW50cyIsIm1hbmFnZS1jbGllbnRzIiwicXVlcnktZ3JvdXBzIiwicXVlcnktdXNlcnMiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoicHJvZmlsZSBlbWFpbCIsImVtYWlsX3ZlcmlmaWVkIjp0cnVlLCJuYW1lIjoiYWRtaW4gYWRtaW4iLCJwcmVmZXJyZWRfdXNlcm5hbWUiOiJhZG1pbiIsImdpdmVuX25hbWUiOiJhZG1pbiIsImZhbWlseV9uYW1lIjoiYWRtaW4iLCJlbWFpbCI6ImFkbWluQGFwcC5hY3Rpdml0aS5jb20ifQ.NWddSC7DzTOWFYWBx5iD545pvt6PdpfJ_nkWDqe078TR-ZJYNll0exS8MrWG1APvFM8eBUuMLjkmYkL9Ao7qXNacR05PRLfRc9kElnWuv2TIIjQze456mVO2gGSPW2tiHxltHDbhC5FIzn8q_kntR6piCQw_aHnv_yWPShwgx2f5OflQ8JB8fvfehQuj9-mDVqLRynLczSRk6HJ6aDLmyj4T-h6IVouInR22KYg_NFg_FI86oZ6hi1zEfWCc8Zgs_4oYlFutCgybts0hzrhKvc_MPK2qLOzFdUN9IRASN0gEWSwhTjOcTkplmjJV6tzu_9RXHz-wZDrYbo_QtwoVkA"
    static let accessTokenExpiresInGood = 300
    static let refreshTokenGood = "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICI0ZWI3MzE5NC0zNDhiLTQxYTYtYjQyNS03MDc3ODgwOTQzYTMifQ.eyJqdGkiOiI3ODM5MmM0Yy1lZjNjLTRiOGItOWE4OC04ZTAwNDNlNjVhMmUiLCJleHAiOjE1Njc2NjY5MjMsIm5iZiI6MCwiaWF0IjoxNTY3NjY2ODYzLCJpc3MiOiJodHRwOi8vYWxmcmVzY28taWRlbnRpdHktc2VydmljZS5tb2JpbGUuZGV2LmFsZnJlc2NvLm1lL2F1dGgvcmVhbG1zL2FsZnJlc2NvIiwiYXVkIjoiaHR0cDovL2FsZnJlc2NvLWlkZW50aXR5LXNlcnZpY2UubW9iaWxlLmRldi5hbGZyZXNjby5tZS9hdXRoL3JlYWxtcy9hbGZyZXNjbyIsInN1YiI6IjYwYTliNmM1LTY0ZWYtNDA1Zi04YzZmLTY2YmQ4Y2QzODc4YSIsInR5cCI6IlJlZnJlc2giLCJhenAiOiJhbGZyZXNjbyIsImF1dGhfdGltZSI6MCwic2Vzc2lvbl9zdGF0ZSI6IjIxZDM0NTllLTlkNzQtNGFjZi05NTEzLTZiMWMwNzBhOTA3MyIsInJlYWxtX2FjY2VzcyI6eyJyb2xlcyI6WyJBQ1RJVklUSV9NT0RFTEVSIiwib2ZmbGluZV9hY2Nlc3MiLCJBQ1RJVklUSV9BRE1JTiIsIkFDVElWSVRJX1VTRVIiLCJ1bWFfYXV0aG9yaXphdGlvbiIsInVzZXIiXX0sInJlc291cmNlX2FjY2VzcyI6eyJyZWFsbS1tYW5hZ2VtZW50Ijp7InJvbGVzIjpbInZpZXctcmVhbG0iLCJtYW5hZ2UtcmVhbG0iLCJtYW5hZ2UtdXNlcnMiLCJ2aWV3LXVzZXJzIiwidmlldy1jbGllbnRzIiwicXVlcnktY2xpZW50cyIsIm1hbmFnZS1jbGllbnRzIiwicXVlcnktZ3JvdXBzIiwicXVlcnktdXNlcnMiXX0sImFjY291bnQiOnsicm9sZXMiOlsibWFuYWdlLWFjY291bnQiLCJtYW5hZ2UtYWNjb3VudC1saW5rcyIsInZpZXctcHJvZmlsZSJdfX0sInNjb3BlIjoicHJvZmlsZSBlbWFpbCJ9.osHzgHQSqcVNr7PaDv_dSBfSPryBHJMQlmH0HKU06y0"
    static let refreshTokenExpiresInGood = 1800
    static let tokenTypeGood = "bearer"
    static let sessionStateGood = "21d3459e-9d74-4acf-9513-6b1c070a9073"
    static let dictionaryAlfrescoCredentialGood = [
        "access_token": accessTokenGood,
        "expires_in": accessTokenExpiresInGood,
        "refresh_expires_in": refreshTokenExpiresInGood,
        "refresh_token": refreshTokenGood,
        "token_type": tokenTypeGood,
        "session_state": sessionStateGood
        ] as [String : Any]
    static let dictionaryAlfrescoCredentialExtra = [
    "access_token": accessTokenGood,
    "expires_in": accessTokenExpiresInGood,
    "refresh_expires_in": refreshTokenExpiresInGood,
    "refresh_token": refreshTokenGood,
    "token_type": tokenTypeGood,
    "session_state": sessionStateGood,
    "scope": "profile email"
    ] as [String : Any]
    
}
