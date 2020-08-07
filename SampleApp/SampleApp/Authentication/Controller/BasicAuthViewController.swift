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

class BasicAuthViewController: UIViewController {
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    var viewModel: BasicAuthenticationViewModel?
    var authenticationProvider: AuthenticationProviderProtocol?

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "basic-recents" {
            if let recentsViewController = segue.destination as? RecentsViewController {
                let viewModel = RecentsViewModel()
                viewModel.authenticationProvider = authenticationProvider
                viewModel.authenticationService = self.viewModel?.authenticationService
                viewModel.delegate = recentsViewController
                recentsViewController.viewModel = viewModel
            }
        }
    }

    @IBAction func signInTapped(_ sender: Any) {
        guard let username = usernameTextField.text, let password = passwordTextField.text else { return }
        viewModel?.authenticate(username: username, password: password)
    }
}

extension BasicAuthViewController: BasicAuthViewModelDelegate {
    func logInSuccessful(with credential: BasicAuthCredential) {
        authenticationProvider = BasicAuthenticationProvider(with: credential)
        self.performSegue(withIdentifier: "basic-recents", sender: nil)
    }

    func logInFailed(with error: APIError) {
        print(error)
    }
}
