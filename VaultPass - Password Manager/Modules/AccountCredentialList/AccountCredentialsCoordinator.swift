//
//  AccountCredentialsCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

class AccountCredentialsCoordinator: AccountCredentialsDelegate {
    
    var accountManager: AccountCredentialsManager
    var navigation: UINavigationController
    
    init(accountManager: AccountCredentialsManager, navigation: UINavigationController) {
        self.accountManager = accountManager
        self.navigation = navigation
    }
    
    private func pushConfigureCredential(with index: Int?) {
        let factory = CredentialConfigureFactory()
        let configureController = factory.makeMediatingController(manager: self.accountManager, index: index, navigation: self.navigation)
        self.navigation.pushViewController(configureController, animated: true)
    }
    
    func accountCredentialsViewDidLoad(_ displayable: AccountCredentialsDisplayable) {
    }
    
    func accountCredentialsViewDidAppear(_ displayable: AccountCredentialsDisplayable) {
        let credentials = accountManager.fetchCredentials()
        if credentials.isEmpty {
            displayable.displayError()
        }
        displayable.updateAccountCredentials(credentials)
    }
    
    func accountCredentialsAddButtonPressed() {
        self.pushConfigureCredential(with: nil)
    }
    
    func accountCredentialsSettingsButtonPressed() {
        let factory = SettingsFactory()
        let settingsController = factory.makeMediatingController(manager: self.accountManager, navigation: self.navigation)
        self.navigation.pushViewController(settingsController, animated: true)
    }
    
    func accountCredentialsSaveCredentials(_ credentials: [AccountCredential]) {
        let _ = self.accountManager.storeCredentials(credentials)
    }
    
    func accountCredentialsEditCredential(_ displayable: AccountCredentialsDisplayable, index: Int?) {
        guard let index else {
            displayable.displayError()
            return
        }
        self.pushConfigureCredential(with: index)
    }
}
