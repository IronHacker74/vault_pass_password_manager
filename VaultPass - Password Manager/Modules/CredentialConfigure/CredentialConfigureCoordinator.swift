//
//  CredentialConfigureCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/12/23.
//

import UIKit

class CredentialConfigureCoordinator: CredentialConfigureDelegate {
    
    let factory: CredentialConfigureFactory
    
    let credentialManager: AccountCredentialsManager
    var currentCredential: AccountCredential?
    var credentials: [AccountCredential] = []
    let index: Int?
    let navigation: UINavigationController
    
    init(factory: CredentialConfigureFactory, manager: AccountCredentialsManager, index: Int?, navigation: UINavigationController) {
        self.factory = factory
        self.credentialManager = manager
        self.index = index
        self.navigation = navigation
    }
    
    func credentialConfigureViewDidLoad(displayable: CredentialConfigureDisplayable) {
        self.credentials = self.credentialManager.fetchCredentials()
        if let index {
            let credential = self.credentials[index]
            displayable.fillFields(with: credential)
        } else {
            displayable.hideDeleteButton()
        }
    }
    
    func credentialConfigureViewWillDisappear() {
    }
    
    func generatePassword() -> String {
        return self.credentialManager.generatePassword()
    }
    
    func passwordSettingsPressed() {
        let factory = SettingsFactory()
        let controller = factory.makeMediatingController(manager: self.credentialManager, navigation: self.navigation)
        self.navigation.pushViewController(controller, animated: true)
    }
    
    func passwordTextFieldDidChange(_ displayable: CredentialConfigureDisplayable, text: String) {
        var passwordStrengthColor: UIColor = .red
        if !text.isEmpty {
            passwordStrengthColor = self.credentialManager.getPasswordStrengthColor(for: text)
        }
        displayable.changePasswordViewBackground(with: passwordStrengthColor)
    }
    
    func deleteButtonPressed() {
        CustomAlert.destructive(self.navigation, title: "Are you sure?", message: "Deleting this credential will be permanent!", style: .alert, deleteBtn: "Delete", deleteAction: {_ in 
            if let index = self.index {
                self.credentials.remove(at: index)
                self.storeCredentialsAndPop()
            }
        })
    }
    
    func saveCredential(_ credential: AccountCredential) {
        if let index = self.index {
            self.credentials[index] = credential
        } else {
            self.credentials.append(credential)
        }
        self.storeCredentialsAndPop()
    }
    
    private func storeCredentialsAndPop(){
        if self.credentialManager.storeCredentials(self.credentials) {
            self.navigation.popViewController(animated: true)
        } else {
            CustomAlert.ok(self.navigation, title: "Oops!", message: "We can't save your credential at this time.", style: .alert)
        }
    }
}
