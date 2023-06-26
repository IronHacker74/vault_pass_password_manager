//
//  LoginFactory.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

class LoginFactory {
    
    func makeMediatingController(navigation: UINavigationController) -> UIViewController {
        let controller = LoginMediatingController()
        let delegate = makeCoordinator(navigation: navigation)
        controller.delegate = delegate
        return controller
    }
    
    func makeCoordinator(navigation: UINavigationController) -> LoginDelegate {
        return LoginCoordinator(factory: self, navigation: navigation)
    }
}
