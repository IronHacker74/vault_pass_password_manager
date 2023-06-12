//
//  AccountCredentialsMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 4/2/23.
//

import UIKit

protocol AccountCredentialsDelegate {
    func accountCredentialsViewDidLoad(_ controller: UIViewController)
    func accountCredentialsViewDidAppear(_ displayable: AccountCredentialsDisplayable)
    func accountCredentialCellWasTapped()
}

protocol AccountCredentialsDisplayable {
    func updateAccountCredentials(_ credentials: [AccountCredential])
    func displayError()
}

class AccountCredentialsMediatingController: UIViewController, AccountCredentialsDisplayable {
    
    @IBOutlet private(set) var tableview: UITableView!
    
    var delegate: AccountCredentialsDelegate?
    private var credentials: [AccountCredential] = []
    private let cellIdentifier = "AccountCredentialCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableview.dataSource = self
        self.tableview.delegate = self
        self.tableview.register(UINib(nibName: cellIdentifier, bundle: nil), forCellReuseIdentifier: cellIdentifier)
        self.delegate?.accountCredentialsViewDidLoad(self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.delegate?.accountCredentialsViewDidAppear(self)
    }

    private func configureNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "My Credentials"
        // TODO: Add button on left and right side of navigation bar for settings and adding a password, respectively.
    }
    
    func updateAccountCredentials(_ credentials: [AccountCredential]) {
        self.credentials = credentials
        self.tableview.reloadData()
    }
    
    func displayError() {
        // TODO: create and display an error pop up.
    }
}

extension AccountCredentialsMediatingController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return credentials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? AccountCredentialCell else {
            return UITableViewCell()
        }
        cell.configureCell(title: "Amazon")
        return cell
    }
    
    
}

