//
//  LoginMediatingControllerTests.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/21/23.
//


import XCTest
@testable import VaultPass___Password_Manager

final class LoginMediatingControllerTests: XCTestCase {
    
    override class func setUp() {
        
    }
    
    override func tearDownWithError() throws {
        
    }
    
    func testIBOutletsNotNil() {
        // given
        let controller = LoginMediatingController.loadFromNibMain()
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.loginButton)
        XCTAssertNotNil(controller.loginDetailLabel)
        XCTAssertNotNil(controller.termsAndConditionsBtn)
        XCTAssertNotNil(controller.privacyPolicyBtn)
    }
}
