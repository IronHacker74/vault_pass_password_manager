//
//  SettingsFactory.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/14/23.
//

import UIKit

class SettingsFactory {
    
    func makeMediatingController(manager: AccountCredentialsManager, navigation: UINavigationController) -> UIViewController {
        let delegate = SettingsCoordinator(credentialsManager: manager, navigation: navigation)
        let controller = SettingsMediatingController(delegate: delegate)
        return controller
    }
}
