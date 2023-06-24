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
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            // TODO: Fail message?
            return
        }
        Task {
            do {
                try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Log in to manager your passwords")
                print("Succcessful authentication")
                DispatchQueue.main.async {
                    self.pushAccountCredentialsController()
                }
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func pushAccountCredentialsController() {
        let notFirstLogin = self.loginData.getNotFirstLogin()
        let factory = AccountCredentialsFactory()
        let manager = AccountCredentialsManager(firstTimeLogin: notFirstLogin)
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
