//
//  AccountCredentialsMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 4/2/23.
//

import UIKit

protocol AccountCredentialsDelegate {
    func accountCredentialCellWasTapped()
}

class AccountCredentialsMediatingController: UIViewController {
    
    @IBOutlet private(set) var tableview: UITableView!
    
    var delegate: AccountCredentialsDelegate?
    var cellIdentifier = "AccountCredentialCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
    }

    private func configureNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "My Credentials"
        // TODO: Add button on left and right side of navigation bar for settings and adding a password, respectively.
    }
    
}

extension AccountCredentialsMediatingController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3 // TODO: return the number of credentials the user has saved
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AccountCredentialCell else {
            return UITableViewCell()
        }
        cell.configureCell(title: "Amazon")
        return cell
    }
    
    
}

