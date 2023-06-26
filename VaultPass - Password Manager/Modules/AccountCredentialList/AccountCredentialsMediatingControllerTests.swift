//
//  AccountCredentialsMediatingControllerTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 6/22/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class AccountCredentialsMediatingControllerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testIBOutletsNonNil() {
        // given
        let factory = AccountCredentialsFactory()
        let nav = factory.makeMediatingController(accountManager: AccountCredentialsManager()) as! UINavigationController
        let sut = nav.viewControllers.first as! AccountCredentialsMediatingController
        // when
        sut.loadViewIfNeeded()
        // then
        XCTAssertNotNil(sut.tableview)
        XCTAssertNotNil(sut.searchBar)
        XCTAssertNotNil(sut.navigationItem.rightBarButtonItem)
        XCTAssertNotNil(sut.navigationItem.leftBarButtonItem)
    }
    
    func testSearchFiltersCredentials() {
        // given
        let factory = AccountCredentialsFactory()
        let nav = factory.makeMediatingController(accountManager: AccountCredentialsManager()) as! UINavigationController
        let sut = nav.viewControllers.first as! AccountCredentialsMediatingController
        let string = "s"
        let cred1 = AccountCredential(title: string, username: string, password: string)
        let cred2 = AccountCredential(title: string, username: string, password: string)
        // when
        sut.loadViewIfNeeded()
        sut.updateAccountCredentials([cred1, cred2])
        sut.searchBar.searchTextField.text = "t"
        sut.tableview.reloadData()
        // then
        XCTAssertEqual(sut.tableview.numberOfRows(inSection: 0), 0)
    }

    func testThatCredentialsAreSortedWithIndex() {
        // given
        let factory = AccountCredentialsFactory()
        let nav = factory.makeMediatingController(accountManager: AccountCredentialsManager()) as! UINavigationController
        let sut = nav.viewControllers.first as! AccountCredentialsMediatingController
        // when
        sut.loadViewIfNeeded()
        // then
        XCTAssertNotEqual(sut.tableview.numberOfRows(inSection: 0), 0)
        for index in 0..<sut.tableview.numberOfRows(inSection: 0) {
            let cell = sut.tableview.cellForRow(at: IndexPath(row: index, section: 0)) as! AccountCredentialCell
            XCTAssertEqual(index, cell.index)
        }
    }
    
    func testUsernameCopyToClipboard() {
        // given
        let factory = AccountCredentialsFactory()
        let nav = factory.makeMediatingController(accountManager: AccountCredentialsManager()) as! UINavigationController
        let sut = nav.viewControllers.first as! AccountCredentialsMediatingController
        let string = "s"
        let cred = AccountCredential(title: string, username: string, password: string)
        // when
        sut.cellUsernameButtonTapped(credential: cred)
        // then
        XCTAssertEqual(UIPasteboard.general.string, string)
    }
    
    func testpasswordCopyToClipboard() {
        // given
        let factory = AccountCredentialsFactory()
        let nav = factory.makeMediatingController(accountManager: AccountCredentialsManager()) as! UINavigationController
        let sut = nav.viewControllers.first as! AccountCredentialsMediatingController
        let string = "s"
        let cred = AccountCredential(title: string, username: string, password: string)
        // when
        sut.cellPasswordButtonTapped(credential: cred)
        // then
        XCTAssertEqual(UIPasteboard.general.string, string)
    }
}
