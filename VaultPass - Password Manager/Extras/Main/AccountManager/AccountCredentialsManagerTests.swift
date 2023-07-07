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
            AccountCredential(title: "amazon", identifier: "id1", username: "username", password: "password"),
            AccountCredential(title: "amazon1", identifier: "id2", username: "username1", password: "password1"),
            AccountCredential(title: "amazon2", identifier: "id3", username: "username2", password: "username2")
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
            AccountCredential(title: "amazon", identifier: "id1", username: "username", password: "password"),
            AccountCredential(title: "amazon1", identifier: "id2", username: "username1", password: "password1"),
            AccountCredential(title: "amazon2", identifier: "id3", username: "username2", password: "username2")
        ]
        // when
        let _ = manager.storeCredentials(testAccounts)
        let credentials = manager.fetchCredentials()
        // then
        XCTAssertEqual(credentials, testAccounts)
    }
    
    func testPasswordStrengthIsNone() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        // when
        manager.toggleStringType(of: .lowerCase)
        manager.toggleStringType(of: .upperCase)
        manager.toggleStringType(of: .numbers)
        manager.toggleStringType(of: .specialChar)
        // then
        XCTAssertEqual(.none, manager.passwordStrength())
        XCTAssertEqual(.black, manager.passwordStrengthColor())
    }
    
    func testPasswordStrengthIsBad() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        // when
        manager.toggleStringType(of: .lowerCase)
        manager.toggleStringType(of: .upperCase)
        manager.toggleStringType(of: .specialChar)
        manager.changePasswordLength(8)
        // then
        XCTAssertEqual(.bad, manager.passwordStrength())
        XCTAssertEqual(.red, manager.passwordStrengthColor())
    }
    
    func testPasswordStrengthIsOkay() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        // when
        manager.toggleStringType(of: .lowerCase)
        manager.changePasswordLength(10)
        // then
        XCTAssertEqual(.okay, manager.passwordStrength())
        XCTAssertEqual(.orange, manager.passwordStrengthColor())
    }
    
    func testPasswordStrengthIsGood() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        // when
        manager.toggleStringType(of: .lowerCase)
        manager.toggleStringType(of: .upperCase)
        // then
        XCTAssertEqual(.good, manager.passwordStrength())
        XCTAssertEqual(.yellow, manager.passwordStrengthColor())
    }
    
    func testPasswordStrengthIsBest() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        // when
        manager.toggleStringType(of: .specialChar)
        manager.changePasswordLength(18)
        // then
        XCTAssertEqual(.best, manager.passwordStrength())
        XCTAssertEqual(.green, manager.passwordStrengthColor())
    }

    
    func testPerformanceOfStoringCredentials() {
        // given
        var credentials: [AccountCredential] = []
        let manager = AccountCredentialsManager()
        let numOfCreds = 10000
        // when
        for _ in 0..<numOfCreds {
            credentials.append(AccountCredential(title: manager.generatePassword(), identifier: manager.generatePassword(), username: manager.generatePassword(), password: manager.generatePassword()))
        }
        // then
        measure {
            let _ = manager.storeCredentials(credentials)
            let _ = manager.fetchCredentials()
        }
    }
}
