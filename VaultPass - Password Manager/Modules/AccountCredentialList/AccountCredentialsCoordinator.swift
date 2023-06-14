//
//  AccountCredentialsCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

class AccountCredentialsCoordinator: AccountCredentialsDelegate {
    
    var accountManager: AccountCredentialsManager
    
    init(accountManager: AccountCredentialsManager) {
        self.accountManager = accountManager
    }
    
    func accountCredentialsViewDidLoad(_ controller: UIViewController) {
    }
    
    func accountCredentialsViewDidAppear(_ displayable: AccountCredentialsDisplayable) {
        let credentials = accountManager.fetchCredentials()
        if credentials.isEmpty {
            displayable.displayError()
        }
        displayable.updateAccountCredentials(credentials)
    }
    
    func accountCredentialsAddButtonPressed(_ controller: UIViewController) {
        let factory = CredentialConfigureFactory()
        let configureController = factory.makeMediatingController(manager: self.accountManager)
        controller.navigationController?.pushViewController(configureController, animated: true)
    }
    
    func accountCredentialsSettingsButtonPressed(_ controller: UIViewController) {
        // TODO: push settings screen
    }
}
