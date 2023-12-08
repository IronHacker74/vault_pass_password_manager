//
//  ManagePaymentMediatingControllerTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 12/5/23.
//

import XCTest
@testable import VaultPass

final class ManagePaymentMediatingControllerTests: XCTestCase {

    func testIBOutletsAreNotNil() {
        // given
        let controller = ManagePaymentMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.continueButton)
        XCTAssertNotNil(controller.cancelButton)
        XCTAssertNotNil(controller.monthlySubscriptionView)
        XCTAssertNotNil(controller.monthlySubscriptionButton)
        XCTAssertNotNil(controller.oneTimePurchaseView)
        XCTAssertNotNil(controller.oneTimePurchaseButton)
    }
    
    func testIBActionsAreNotNil() {
        // given
        let controller = ManagePaymentMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.continueButton.actions(forTarget: controller, forControlEvent: .touchUpInside))
        XCTAssertNotNil(controller.cancelButton.actions(forTarget: controller, forControlEvent: .touchUpInside))
        XCTAssertNotNil(controller.monthlySubscriptionButton.actions(forTarget: controller, forControlEvent: .touchUpInside))
        XCTAssertNotNil(controller.monthlySubscriptionView.gestureRecognizers?.first)
        XCTAssertNotNil(controller.oneTimePurchaseButton.actions(forTarget: controller, forControlEvent: .touchUpInside))
        XCTAssertNotNil(controller.oneTimePurchaseView.gestureRecognizers?.first)
    }
}
