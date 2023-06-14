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
    
    init(factory: LoginFactory, navigation: UINavigationController?) {
        self.factory = factory
        self.navigation = navigation
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
        let factory = AccountCredentialsFactory()
        var controller = factory.makeMediatingController()
        controller = UINavigationController(rootViewController: controller)
        UIApplication.shared.windows.first?.rootViewController = controller
        UIApplication.shared.windows.first?.makeKeyAndVisible()
    }
    
}
