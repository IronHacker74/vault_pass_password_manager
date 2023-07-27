//
//  LoginCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import LocalAuthentication
import UIKit

class LoginCoordinator: LoginDelegate {
    
    var factory: LoginFactory
    var navigation: UINavigationController?
    let loginData = LoginData()
        
    init(factory: LoginFactory, navigation: UINavigationController?) {
        self.factory = factory
        self.navigation = navigation
    }
    
    func loginViewDidAppear() {
        if self.loginData.getAutoLogin() {
            self.loginWithAppleAuth()
        }
    }
    
    func loginWithAppleAuth() {
        BiometricLogin.loginWithAppleAuth(completion: { result, error in
            if result && error == nil {
                self.pushAccountCredentialsController()
            }
        })
    }
    
    private func pushAccountCredentialsController() {
        let factory = AccountCredentialsFactory()
        let manager = AccountCredentialsManager()
        if self.loginData.getNotFirstLogin() == false {
            manager.setPasswordSettingsToDefault()
            self.loginData.setNotFirstLogin(true)
        }
        if self.loginData.getAutoLogin() == false {
            self.loginData.setAutoLogin(true)
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
