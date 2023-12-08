//
//  PaymentConfirmationMediatingControllerTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 12/8/23.
//

import XCTest
@testable import VaultPass

final class PaymentConfirmationMediatingControllerTests: XCTestCase {

    func testIBOutletsAreNotNil() {
        // given
        let controller = PaymentConfirmationMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.doneButton)
    }

    func testIBActionsAreNotNil() {
        // given
        let controller = PaymentConfirmationMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.doneButton.actions(forTarget: controller, forControlEvent: .touchUpInside))
    }
}
