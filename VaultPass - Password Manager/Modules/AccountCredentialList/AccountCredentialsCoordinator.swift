//
//  AccountCredentialsCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

class AccountCredentialsCoordinator: AccountCredentialsDelegate {
    
    private var accountManager: AccountCredentialsManager
    private var navigation: UINavigationController
    
    init(accountManager: AccountCredentialsManager, navigation: UINavigationController) {
        self.accountManager = accountManager
        self.navigation = navigation
    }
    
    private func pushConfigureCredential(with index: Int?) {
        let factory = CredentialConfigureFactory()
        let coordinator = factory.makeCoordinator(manager: accountManager, index: index, navigation: self.navigation)
        let configureController = factory.makeMediatingController(coordinator: coordinator)
        self.navigation.pushViewController(configureController, animated: true)
    }
    
    func accountCredentialsViewDidLoad(_ displayable: AccountCredentialsDisplayable) {
    }
    
    func accountCredentialsViewDidAppear(_ displayable: AccountCredentialsDisplayable) {
        self.accountCredentialsGetCredentials(displayable)
    }
    
    func accountCredentialsAddButtonPressed() {
        self.pushConfigureCredential(with: nil)
    }
    
    func accountCredentialsSettingsButtonPressed() {
        let factory = SettingsFactory()
        let settingsController = factory.makeMediatingController(manager: self.accountManager, navigation: self.navigation)
        self.navigation.pushViewController(settingsController, animated: true)
    }
    
    func accountCredentialsGetCredentials(_ displayable: AccountCredentialsDisplayable) {
        let credentials = accountManager.fetchCredentials()
        displayable.updateAccountCredentials(credentials)
    }
    
    func accountCredentialsSaveCredentials(_ credentials: [AccountCredential]) {
        let _ = self.accountManager.storeCredentials(credentials)
    }
    
    func accountCredentialsEditCredential(_ displayable: AccountCredentialsDisplayable, index: Int) {
        self.pushConfigureCredential(with: index)
    }
}
