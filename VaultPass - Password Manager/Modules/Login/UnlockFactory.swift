//
//  UnlockFactory.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

class UnlockFactory {
    
    func makeMediatingController(navigation: UINavigationController) -> UIViewController {
        let controller = UnlockMediatingController()
        let delegate = makeCoordinator(navigation: navigation)
        controller.delegate = delegate
        return controller
    }
    
    func makeCoordinator(navigation: UINavigationController) -> UnlockDelegate {
        return UnlockCoordinator(factory: self, navigation: navigation)
    }
}
