//
//  ManagePaymentCoordinator.swift
//  VaultPass
//
//  Created by Andrew Masters on 12/5/23.
//

import UIKit

final class ManagePaymentCoordinator: ManagePaymentDelegate {
    let navigation: UINavigationController
    let factory: ManagePaymentFactory
    
    init(navigation: UINavigationController, factory: ManagePaymentFactory) {
        self.navigation = navigation
        self.factory = factory
    }
    
    func managePaymentMediatingControllerDidTouchContinue(paymentType: PaymentType) {
//        if paymentType == .monthlySubscription {
//            // TODO: process monthly subscription
//        } else {
//            // TODO: process one-time payment
//        }
        let controller = self.factory.makeConfirmationMediatingController(delegate: self)
        self.navigation.pushViewController(controller, animated: true)
    }
    
    func managePaymentMediatingControllerDidTouchCancel() {
        self.navigation.popViewController(animated: true)
    }
    
    func managePaymentMediatingControllerDidTouchDone() {
        self.navigation.popToRootViewController(animated: true)
    }
}
