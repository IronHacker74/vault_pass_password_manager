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
    
    init(factory: CredentialConfigureFactory, manager: AccountCredentialsManager) {
        self.factory = factory
        self.credentialManager = manager
    }
    
    func generatePassword() -> String {
        return self.credentialManager.generatePassword()
    }
    
    func saveCredentialToStore(_ controller: UIViewController, title: String, username: String, password: String) {
        let credential = AccountCredential(title: title, username: username, password: password)
        controller.navigationController?.popViewController(animated: true)
    }
}
