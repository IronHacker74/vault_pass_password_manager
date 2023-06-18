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
    
    private func pushConfigureCredential() {
        let factory = CredentialConfigureFactory()
        let configureController = factory.makeMediatingController(manager: self.accountManager, credential: nil)
        self.navigation.pushViewController(configureController, animated: true)
    }
    
    func accountCredentialsViewDidLoad(_ controller: UIViewController) {
    }
    
    func accountCredentialsViewDidAppear(_ displayable: AccountCredentialsDisplayable) {
        let credentials = accountManager.fetchCredentials()
        if credentials.isEmpty {
            displayable.displayError()
        }
        displayable.updateAccountCredentials(credentials.sorted(by: { $0.title < $1.title }))
    }
    
    func accountCredentialsAddButtonPressed() {
        self.pushConfigureCredential()
    }
    
    func accountCredentialsSettingsButtonPressed() {
        let factory = SettingsFactory()
        let settingsController = factory.makeMediatingController(manager: self.accountManager, navigation: self.navigation)
        self.navigation.pushViewController(settingsController, animated: true)
    }
    
    func accountCredentialsSaveCredentials(_ credentials: [AccountCredential]) {
        let _ = self.accountManager.storeCredentials(credentials)
    }
    
    func accountCredentialsEditCredential(credential: AccountCredential) {
        self.pushConfigureCredential()
    }
}
