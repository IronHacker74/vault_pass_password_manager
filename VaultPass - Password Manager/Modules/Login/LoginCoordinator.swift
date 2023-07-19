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
        if self.loginData.getNotFirstLogin() {
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
        let notFirstLogin = self.loginData.getNotFirstLogin()
        let factory = AccountCredentialsFactory()
        let manager = AccountCredentialsManager()
        if notFirstLogin == false {
            manager.setPasswordSettingsToDefault()
            self.loginData.setNotFirstLogin(true)
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
