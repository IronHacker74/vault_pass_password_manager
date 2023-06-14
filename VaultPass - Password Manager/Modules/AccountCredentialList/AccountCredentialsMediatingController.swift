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
    func accountCredentialsAddButtonPressed(_ controller: UIViewController)
    func accountCredentialsSettingsButtonPressed(_ controller: UIViewController)
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.configureNavigationBar()
    }

    private func configureNavigationBar() {
        self.navigationItem.title = "My Credentials"
        self.navigationItem.setLeftBarButton(makeSettingsButton(), animated: false)
        self.navigationItem.setRightBarButton(makeAddButton(), animated: false)
    }
    
    func updateAccountCredentials(_ credentials: [AccountCredential]) {
        self.credentials = credentials
        self.tableview.reloadData()
    }
    
    func displayError() {
        // TODO: create and display an error pop up.
    }
    
    private func makeAddButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(systemName: "plus"), style: .plain, target: self, action: #selector(addButtonPressed))
        button.tintColor = .systemBlue
        return button
    }
    
    private func makeSettingsButton() -> UIBarButtonItem {
        let button = UIBarButtonItem(image: UIImage(systemName: "gear"), style: .plain, target: self, action: #selector(settingsButtonPressed))
        button.tintColor = .systemBlue
        return button
    }
    
    @objc func addButtonPressed() {
        self.delegate?.accountCredentialsAddButtonPressed(self)
    }
    
    @objc func settingsButtonPressed() {
        self.delegate?.accountCredentialsSettingsButtonPressed(self)
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
        let title = self.credentials[indexPath.row].title
        cell.configureCell(title: title)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AccountCredentialCell else {
            return
        }
        cell.reveal(credential: self.credentials[indexPath.row])
        
    }
}

