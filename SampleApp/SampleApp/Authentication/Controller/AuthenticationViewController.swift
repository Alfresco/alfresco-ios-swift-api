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

class AuthenticationViewController: UIViewController {
    @IBOutlet weak var urlTextField: UITextField!
    var viewModel: AuthenticationViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        urlTextField.text = "mobileapps.envalfresco.com"
    }

    @IBAction func signInTapped(_ sender: Any) {
        viewModel?.availableAuthType(for: urlTextField.text ?? "")
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "sso":
            if let ssoViewController = segue.destination as? SSOAuthenticationViewController {
                let viewModel = SSOAuthenticationViewModel()
                viewModel.authenticationService = self.viewModel?.authenticationService
                viewModel.delegate = ssoViewController
                ssoViewController.viewModel = viewModel
            }
        case "basic":
            if let basicAuthViewController = segue.destination as? BasicAuthViewController {
                let viewModel = BasicAuthenticationViewModel()
                viewModel.authenticationService = self.viewModel?.authenticationService
                viewModel.delegate = basicAuthViewController
                basicAuthViewController.viewModel = viewModel
            }
        default:
            return
        }
    }
}

extension AuthenticationViewController: AuthenticationViewModelDelegate {
    func authServiceAvailable(for authType: AvailableAuthType) {
        switch authType {
        case .aimsAuth:
            if let authParams = viewModel?.authenticationService?.parameters {
                authParams.contentURL = urlTextField.text ?? ""
                viewModel?.authenticationService?.update(authenticationParameters: authParams)
            }

            performSegue(withIdentifier: "sso", sender: nil)
        case .basicAuth:
            performSegue(withIdentifier: "basic", sender: nil)
        }
    }

    func authServiceUnavailable(with error: APIError) {
        print(error)
    }
}

extension AuthenticationViewController: StoryboardInstantiable {}

