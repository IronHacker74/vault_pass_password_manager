//
//  SettingsCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/14/23.
//

import UIKit

class SettingsCoordinator: PasswordSettingsCoordinator, SettingsDelegate {
    
    private let navigation: UINavigationController
    private let unlockData: UnlockData = UnlockData()
    
    init(credentialsManager: AccountCredentialsManager, navigation: UINavigationController) {
        self.navigation = navigation
        super.init(credentialsManager: credentialsManager)
    }
    
    func settingsControllerViewDidLoad(_ displayable: SettingsDisplayable) {
        displayable.setAutoUnlockSwitch(self.unlockData.getAutoUnlock())
    }
    
    func toggleAutoUnlock() {
        let value = self.unlockData.getAutoUnlock()
        self.unlockData.setAutoUnlock(value.toggle())
    }
    
    func termsAndConditionsTapped() {
        let factory = TermsAndConditionsFactory()
        let controller = factory.makeMediatingController()
        self.navigation.present(controller, animated: true)
    }

    func lockButtonPressed() {
        CustomAlert.destructive(self.navigation, title: "Lock your credentials?", message: "Are you sure you want to relock your data?", style: .actionSheet, deleteBtn: "Lock", deleteAction: { _ in
            self.unlockData.setAutoUnlock(false)
            self.sendBackToUnlockScreen()
        })
    }
    
    func deleteAllData() {
        CustomAlert.destructive(self.navigation, title: "Are you sure you want to delete everything?", message: "This action is irreversible and will be permanent", style: .alert, deleteBtn: "Delete", deleteAction: { _ in
            self.credentialsManager.deleteAllData()
            self.unlockData.deleteData()
            KeychainService.standard.deleteKey()
            self.sendBackToUnlockScreen()
        })
    }
    
    private func sendBackToUnlockScreen() {
        let factory = UnlockFactory()
        let controller = UnlockMediatingController.loadFromNibMain()
        controller.delegate = factory.makeCoordinator(navigation: UINavigationController())
        UIApplication.shared.windows.first?.rootViewController = controller
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
}
