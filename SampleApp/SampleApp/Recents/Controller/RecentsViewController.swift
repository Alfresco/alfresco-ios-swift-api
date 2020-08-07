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

class RecentsViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: RecentsViewModel?

    override func viewDidLoad() {
        super.viewDidLoad()

        viewModel?.fetchRecentsList()
    }
    
    @IBAction func logoutTapped(_ sender: Any) {
        viewModel?.logout(on: self)
    }

    @IBAction func refreshSessionTapped(_ sender: Any) {
        viewModel?.refreshSession()
    }
}

extension RecentsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.nodes?.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ListCell", for: indexPath) as? ListCell
        if let node = viewModel?.nodes?[indexPath.row] {
            cell?.node = node
        }

        return cell ?? UICollectionViewCell()
    }
}

extension RecentsViewController: RecentsViewModelDelegate {
    func didLogout() {
        self.navigationController?.popToRootViewController(animated: true)
    }

    func didRefreshSession() {
        let alert = UIAlertController.init(title: "", message: "Session refreshed", preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        present(alert, animated: true, completion: nil)
    }

    func didLoadRecents() {
        collectionView.reloadData()
    }
}
