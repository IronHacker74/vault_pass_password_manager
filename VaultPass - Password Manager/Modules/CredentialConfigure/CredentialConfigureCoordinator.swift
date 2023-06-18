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
    let currentCredential: AccountCredential?
    
    init(factory: CredentialConfigureFactory, manager: AccountCredentialsManager, credential: AccountCredential?) {
        self.factory = factory
        self.credentialManager = manager
        self.currentCredential = credential
    }
    
    func generatePassword() -> String {
        return self.credentialManager.generatePassword()
    }
    
    func saveCredentialToStore(_ controller: UIViewController, title: String, username: String, password: String) {
        var credential: AccountCredential
        if let currentCredential {
            credential = currentCredential
        } else {
            credential = AccountCredential(title: title, username: username, password: password)
        }
        var allCredentials = self.credentialManager.fetchCredentials()
        allCredentials.append(credential)
        if self.credentialManager.storeCredentials(allCredentials) {
            controller.navigationController?.popViewController(animated: true)
        } else {
            // TODO: show error
        }
    }
}
