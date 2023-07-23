//
//  TermsAndConditionsMediatingControllerTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 7/21/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class TermsAndConditionsMediatingControllerTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testIBOutletsNotNil() {
        // given
        let sut = TermsAndConditionsMediatingController()
        // when
        sut.loadViewIfNeeded()
        // then
        XCTAssertNotNil(sut.termsAndConditionsTextField)
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertNotNil(sut.exitButton)
    }
    
    func testTitleLabelIsNotEmpty() {
        // given
        let sut = TermsAndConditionsMediatingController()
        // when
        sut.loadViewIfNeeded()
        // then
        XCTAssertFalse(sut.titleLabel.text!.isEmpty)
    }

    func testTermsAndConditionsFileDidImport() {
        // given
        let sut = TermsAndConditionsMediatingController()
        // when
        sut.loadViewIfNeeded()
        // then
        XCTAssertFalse(sut.termsAndConditionsTextField.text.isEmpty)
    }
}
