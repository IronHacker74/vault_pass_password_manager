//
//  AccountCredentialCellTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 6/23/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class AccountCredentialCellTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testIBOutletsNotNil() {
        // given
        let cell = AccountCredentialCell.loadFromNib()
        let string = "s"
        let cred = AccountCredential(title: string, identifier: string, username: string, password: string)
        // when
        cell.configureCell(delegate: nil, credential: cred)
        // then
        XCTAssertNotNil(cell.title)
        XCTAssertNotNil(cell.username)
        XCTAssertNotNil(cell.password)
        XCTAssertNotNil(cell.revealLabel)
    }
    
    func testIBOutletsHoldValues() {
        // given
        let cell = AccountCredentialCell.loadFromNib()
        let string = "s"
        let cred = AccountCredential(title: string, identifier: string, username: string, password: string)
        // when
        cell.configureCell(delegate: nil, credential: cred)
        // then
        XCTAssertEqual(cell.title.text!, string)
    }
    
    func testUsernameAndPasswordIsHidden() {
        // given
        let cell = AccountCredentialCell.loadFromNib()
        let string = "s"
        let cred = AccountCredential(title: string, identifier: string, username: string, password: string)
        // when
        cell.configureCell(delegate: nil, credential: cred)
        // then
        XCTAssertNotEqual(cell.username.title(for: .normal), string)
        XCTAssertNotEqual(cell.password.title(for: .normal), string)
    }
    
    func testUsernameAndPasswordAreRevealed() {
        // given
        let cell = AccountCredentialCell.loadFromNib()
        let string = "s"
        let cred = AccountCredential(title: string, identifier: string, username: string, password: string)
        // when
        cell.configureCell(delegate: nil, credential: cred)
        cell.reveal()
        // then
        XCTAssertFalse(cell.username.isHidden)
        XCTAssertFalse(cell.password.isHidden)
    }
}
