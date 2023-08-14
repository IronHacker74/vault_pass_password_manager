//
//  CredentialProviderViewController.swift
//  AutofillCredentialProvider
//
//  Created by Andrew Masters on 6/25/23.
//

import AuthenticationServices
import UIKit

class CredentialProviderViewController: ASCredentialProviderViewController {
    
    @IBOutlet var tableView: UITableView!
    @IBOutlet var searchBar: UISearchBar!
    
    private var credentials: [AccountCredential] = []
    private var filtered: [AccountCredential] = []
    private let manager = AccountCredentialsManager()
    private var serviceIdentifier: ASCredentialServiceIdentifier? = nil
    private let cellIdentifier: String = "default"
    
    /*
     Prepare your UI to list available credentials for the user to choose from. The items in
     'serviceIdentifiers' describe the service the user is logging in to, so your extension can
     prioritize the most relevant credentials in the list.
    */
    override func prepareCredentialList(for serviceIdentifiers: [ASCredentialServiceIdentifier]) {
        self.serviceIdentifier = serviceIdentifiers.first
        self.loadCredentialsList()
    }
    
    @IBAction func cancel(_ sender: AnyObject?) {
        self.extensionContext.cancelRequest(withError: NSError(domain: ASExtensionErrorDomain, code: ASExtensionError.userCanceled.rawValue))
    }
    
    @IBAction func add(_ sender: AnyObject?) {
        let factory = CredentialConfigureFactory()
        let coordinator = factory.makeCoordinator(manager: manager, index: nil, navigation: UINavigationController(), credentialProviderDelegate: self)
        let controller = factory.makeMediatingController(coordinator: coordinator)
        self.present(controller, animated: true)
    }

    private func loadCredentialsList() {
        var accountCredentials = self.manager.fetchCredentials()
        if let serviceIdentifier = self.serviceIdentifier?.identifier {
            accountCredentials.sort(by: {
                if serviceIdentifier.contains($0.identifier) {
                    return true
                }
                if serviceIdentifier.contains($1.identifier) {
                    return false
                }
                return true
            })
        }
        self.credentials = accountCredentials
        self.tableView.reloadData()
    }
}

extension CredentialProviderViewController: CredentialProviderDelegate {
    func updateCredentials() {
        self.loadCredentialsList()
    }
}

extension CredentialProviderViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.searchIsActive() {
            return self.filtered.count
        }
        return self.credentials.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        var credential: AccountCredential
        if self.searchIsActive() {
            credential = self.filtered[indexPath.row]
        } else {
            credential = self.credentials[indexPath.row]
        }
        cell.textLabel!.text = credential.title
        cell.detailTextLabel!.text = credential.identifier
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var passwordCredential: ASPasswordCredential
        if self.searchIsActive() {
            passwordCredential = self.filtered[indexPath.row].passwordCredential()
        } else {
            passwordCredential = self.credentials[indexPath.row].passwordCredential()
        }
        self.extensionContext.completeRequest(withSelectedCredential: passwordCredential, completionHandler: nil)
    }
}


extension CredentialProviderViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty == false {
            self.filtered = self.credentials.filter({
                $0.title.lowercased().contains(searchText.lowercased())
            })
        } else {
            self.filtered = []
        }
        self.tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.searchBar.endEditing(true)
    }
    
    func searchIsActive() -> Bool {
        if let searchText = self.searchBar.text, searchText.isEmpty == false {
            return true
        }
        return false
    }
}
