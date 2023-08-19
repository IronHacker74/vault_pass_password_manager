//
//  SettingsMediatingControllerTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 6/26/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class SettingsMediatingControllerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    
    func testIBOutletsAreNotNil() {
        // given
        let controller = SettingsMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.passwordSettingsParentView)
        XCTAssertNotNil(controller.termsAndConditionsBtn)
        XCTAssertNotNil(controller.privacyPolicyBtn)
    }
    
    func testCloseButtonIsNotShowing() {
        // given
        let controller = SettingsMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        let passwordSettingsView = controller.passwordSettingsParentView.subviews.first as! PasswordSettingsView
        // then
        XCTAssertTrue(passwordSettingsView.closeButton.isHidden)
        XCTAssertFalse(passwordSettingsView.closeButton.isUserInteractionEnabled)
    }
}
