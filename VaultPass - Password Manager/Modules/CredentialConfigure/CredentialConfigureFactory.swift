//
//  CredentialConfigureFactory.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/12/23.
//

import UIKit

class CredentialConfigureFactory {
    
    func makeMediatingController(manager: AccountCredentialsManager, index: Int?, navigation: UINavigationController) -> UIViewController {
        let coordinator = CredentialConfigureCoordinator(factory: self, manager: manager, index: index, navigation: navigation)
        let controller = CredentialConfigureMediatingController(delegate: coordinator)
        return controller
    }
}
