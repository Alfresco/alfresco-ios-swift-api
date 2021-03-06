//
// Copyright (C) 2005-2020 Alfresco Software Limited.
//
// This file is part of the Alfresco Content Mobile iOS App.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import UIKit
import AlfrescoAuth

class SSOAuthenticationViewController: UIViewController {
    var viewModel: SSOAuthenticationViewModel?
    var authenticationProvider: AIMSAuthenticationProvider?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sso-recents" {
            if let recentsViewController = segue.destination as? RecentsViewController {
                let viewModel = RecentsViewModel()
                viewModel.authenticationProvider = authenticationProvider
                viewModel.ssoCredential = authenticationProvider?.credential
                viewModel.authenticationService = self.viewModel?.authenticationService
                viewModel.delegate = recentsViewController
                recentsViewController.viewModel = viewModel
            }
        }
    }
    
    @IBAction func signInTapped(_ sender: Any) {
        viewModel?.login(in: self)
    }
}

extension SSOAuthenticationViewController: SSOAuthenticationViewModelDelegate {
    func logInFailed(with error: APIError) {
        print(error)
    }

    func logInSuccessful(with credential: AlfrescoCredential) {
        authenticationProvider = AIMSAuthenticationProvider(with: credential)
        self.performSegue(withIdentifier: "sso-recents", sender: nil)
    }
}
