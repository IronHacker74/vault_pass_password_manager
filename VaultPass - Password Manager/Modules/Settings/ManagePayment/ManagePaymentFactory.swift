//
//  ManagePaymentFactory.swift
//  VaultPass
//
//  Created by Andrew Masters on 12/5/23.
//
import UIKit

final class ManagePaymentFactory {
    func makeCoordinator(navigation: UINavigationController) -> ManagePaymentCoordinator {
        return ManagePaymentCoordinator(navigation: navigation, factory: self)
    }
    
    func makeMediatingController(delegate: ManagePaymentCoordinator) -> ManagePaymentMediatingController {
        return ManagePaymentMediatingController(delegate: delegate)
    }
    
    func makeConfirmationMediatingController(delegate: ManagePaymentCoordinator) -> PaymentConfirmationMediatingController {
        return PaymentConfirmationMediatingController(delegate: delegate)
    }
}
