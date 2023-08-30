//
//  PreviewData.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 8/28/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class PreviewData: XCTestCase {
    func testFill() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        
        let titles = ["Apple", "Email", "Exercise App", "Medical Portal", "School Portal", "Shopping App", "Work Login"]
        let identifiers = ["apple.com", "jane.johnson@email.com", "exerciseapp.com", "medicalportal.com", "schoolportal.com", "shop.com", "work.com"]
        let username = ["email", "email", "username", "username", "mySchoolUsername", "username", "email"]
        var accounts: [AccountCredential] = []
        for index in 0..<titles.count {
            accounts.append(AccountCredential(title: titles[index], identifier: identifiers[index], username: username[index], password: manager.generatePassword()))
        }
        // when
        let result = manager.storeCredentials(accounts)
        // then
        XCTAssertTrue(result)
    }
}
