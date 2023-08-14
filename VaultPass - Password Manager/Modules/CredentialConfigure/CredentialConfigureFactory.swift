//
//  CredentialConfigureFactory.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/12/23.
//

import UIKit

class CredentialConfigureFactory {
    
    func makeMediatingController(coordinator: CredentialConfigureCoordinator) -> UIViewController {
        let controller = CredentialConfigureMediatingController(delegate: coordinator)
        return controller
    }
    
    func makeCoordinator(manager: AccountCredentialsManager, index: Int?, navigation: UINavigationController, credentialProviderDelegate: CredentialProviderDelegate? = nil) -> CredentialConfigureCoordinator {
        return CredentialConfigureCoordinator(factory: self, manager: manager, index: index, navigation: navigation, credentialProviderDelegate: credentialProviderDelegate)
    }
}
