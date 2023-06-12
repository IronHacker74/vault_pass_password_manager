//
//  AccountCredentialsManagerTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 6/9/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class AccountCredentialsManagerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }
    
    func testSaveAccountCredentialsIsSuccessful() {
        // given
        let manager = AccountCredentialsManager()
        let testAccounts = [
            AccountCredential(title: "amazon", username: "username", password: "password"),
            AccountCredential(title: "amazon1", username: "username1", password: "password1"),
            AccountCredential(title: "amazon2", username: "username2", password: "username2")
        ]
        // when
        let result = manager.storeCredentials(testAccounts)
        // then
        XCTAssertTrue(result)
    }
    
    func testFetchAccountCredentialsIsSuccessful() {
        // given
        let manager = AccountCredentialsManager()
        let testAccounts = [
            AccountCredential(title: "amazon3", username: "username3", password: "password3"),
            AccountCredential(title: "amazon1", username: "username1", password: "password1"),
            AccountCredential(title: "amazon2", username: "username2", password: "username2")
        ]
        // when
        let _ = manager.storeCredentials(testAccounts)
        let credentials = manager.fetchCredentials()
        // then
        XCTAssertEqual(credentials, testAccounts)
    }

}
