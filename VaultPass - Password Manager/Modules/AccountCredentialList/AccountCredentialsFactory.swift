//
//  AccountCredentialsFactory.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

class AccountCredentialsFactory {
    
    func makeMediatingController() -> UIViewController {
        let controller = AccountCredentialsMediatingController()
        let navigation = UINavigationController(rootViewController: controller)
        let coordinator = makeCoordinator(navigation: navigation)
        controller.delegate = coordinator
        return navigation
    }
    
    func makeCoordinator(navigation: UINavigationController) -> AccountCredentialsDelegate {
        return AccountCredentialsCoordinator(accountManager: AccountCredentialsManager(), navigation: navigation)
    }
}
