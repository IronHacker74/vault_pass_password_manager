//
//  UnlockCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import LocalAuthentication
import UIKit

class UnlockCoordinator: UnlockDelegate {
    
    var factory: UnlockFactory
    var navigation: UINavigationController?
    let unlockData = UnlockData()
        
    init(factory: UnlockFactory, navigation: UINavigationController?) {
        self.factory = factory
        self.navigation = navigation
    }
    
    func unlockViewDidAppear() {
        if self.unlockData.getAutoUnlock() {
            self.unlockWithAppleAuth()
        }
    }
    
    func unlockWithAppleAuth() {
        BiometricUnlock.unlockWithAppleAuth(completion: { result, error in
            if result && error == nil {
                self.pushAccountCredentialsController()
            }
        })
    }
    
    private func pushAccountCredentialsController() {
        let factory = AccountCredentialsFactory()
        let manager = AccountCredentialsManager(iCloudEnabled: true)
        if self.unlockData.getNotFirstUnlock() == false {
            manager.setPasswordSettingsToDefault()
            self.unlockData.setNotFirstUnlock(true)
        }
        if self.unlockData.getAutoUnlock() == false {
            self.unlockData.setAutoUnlock(true)
        }
        let controller = factory.makeMediatingController(accountManager: manager)
        UIApplication.shared.windows.first?.rootViewController = controller
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
    func termsAndConditionsButtonAction() {
        let factory = TermsAndConditionsFactory()
        let controller = factory.makeMediatingController()
        self.navigation?.present(controller, animated: true)
    }
}
