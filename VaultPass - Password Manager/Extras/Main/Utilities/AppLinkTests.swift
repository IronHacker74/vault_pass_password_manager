//
//  AppLinkTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 7/27/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class AppLinkTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTermsAndConditionsLinkOpenable() {
        // given
        let link = AppLinks.termsAndConditions.rawValue
        let url = URL(string: link)!
        // when
        let canOpen = UIApplication.shared.canOpenURL(url)
        // then
        XCTAssertTrue(canOpen)
    }

    func testPrivacyPolicyLinkOpenable() {
        // given
        let link = AppLinks.privacyPolicy.rawValue
        let url = URL(string: link)!
        // when
        let canOpen = UIApplication.shared.canOpenURL(url)
        // then
        XCTAssertTrue(canOpen)
    }
}
