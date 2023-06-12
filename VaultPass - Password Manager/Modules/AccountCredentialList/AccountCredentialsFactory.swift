//
//  AccountCredentialsFactory.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

class AccountCredentialsFactory {
    
    func makeMediatingController() -> UIViewController {
        let coordinator = makeCoordinator()
        let controller = AccountCredentialsMediatingController()
        controller.delegate = coordinator
        return controller
    }
    
    func makeCoordinator() -> AccountCredentialsDelegate {
        return AccountCredentialsCoordinator(accountManager: AccountCredentialsManager())
    }
}
