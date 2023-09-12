//
//  CredentialConfigureMediatingControllerTests.swift
//  VaultPass - Password ManagerTests
//
//  Created by Andrew Masters on 6/26/23.
//

import XCTest
@testable import VaultPass___Password_Manager

final class CredentialConfigureMediatingControllerTests: XCTestCase {

    override func setUpWithError() throws {
    }

    override func tearDownWithError() throws {
    }

    func testIBOutletsNotNil() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: nil)
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertNotNil(controller.scrollView)
        XCTAssertNotNil(controller.titleField)
        XCTAssertNotNil(controller.usernameField)
        XCTAssertNotNil(controller.passwordField)
        XCTAssertNotNil(controller.errorLabel)
        XCTAssertNotNil(controller.saveButton)
        XCTAssertNotNil(controller.deleteBtn)
        XCTAssertNotNil(controller.passwordSettingsBtn)
        XCTAssertNotNil(controller.generatePasswordBtn)
        XCTAssertNotNil(controller.showPasswordBtn)
        XCTAssertNotNil(controller.copyPasswordBtn)
        XCTAssertNotNil(controller.identifierTableView)
        XCTAssertNotNil(controller.addIdentifierButton)
    }
    
    func testCredentialConfigureIsInCreateMode() {
        // given
        let factory = CredentialConfigureFactory()
        let coordinator = factory.makeCoordinator(manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController(rootViewController: UIViewController()))
        let controller = factory.makeMediatingController(coordinator: coordinator) as! CredentialConfigureMediatingController
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertTrue(controller.deleteBtn.isHidden)
    }
    
    func testCredentialConfigureIsInEditMode() {
        // given
        let factory = CredentialConfigureFactory()
        let coordinator = factory.makeCoordinator(manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController(rootViewController: UIViewController()))
        let controller = factory.makeMediatingController(coordinator: coordinator) as! CredentialConfigureMediatingController
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertTrue(controller.deleteBtn.isHidden)
        XCTAssertTrue(controller.titleField.text!.isEmpty)
        XCTAssertTrue(controller.usernameField.text!.isEmpty)
        XCTAssertTrue(controller.passwordField.text!.isEmpty)
    }
    
    func testEmptyCredentialCannotBeAdded() {
        // given
        let factory = CredentialConfigureFactory()
        let coordinator = factory.makeCoordinator(manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController(rootViewController: UIViewController()))
        let controller = factory.makeMediatingController(coordinator: coordinator) as! CredentialConfigureMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.saveButton.sendActions(for: .touchUpInside)
        // then
        XCTAssertFalse(controller.errorLabel.isHidden)
    }
    
    func testOnlyTitleCredentialCannotBeAdded() {
        // given
        let factory = CredentialConfigureFactory()
        let coordinator = factory.makeCoordinator(manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController(rootViewController: UIViewController()))
        let controller = factory.makeMediatingController(coordinator: coordinator) as! CredentialConfigureMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.titleField.text = "Title"
        controller.saveButton.sendActions(for: .touchUpInside)
        // then
        XCTAssertFalse(controller.errorLabel.isHidden)
    }
    
    func testCredentialWasAdded() {
        // given
        let manager = AccountCredentialsManager()
        let currCredNum = manager.fetchCredentials().count
        let factory = CredentialConfigureFactory()
        let coordinator = factory.makeCoordinator(manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController(rootViewController: UIViewController()))
        let controller = factory.makeMediatingController(coordinator: coordinator) as! CredentialConfigureMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.titleField.text = "Title"
        controller.usernameField.text = "username"
        controller.passwordField.text = "password"
        controller.saveButton.sendActions(for: .touchUpInside)
        let newCredNum = manager.fetchCredentials().count
        // then
        XCTAssertEqual(currCredNum + 1, newCredNum)
    }
    
    func testPasswordGeneratorWorks() {
        // given
        let factory = CredentialConfigureFactory()
        let coordinator = factory.makeCoordinator(manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController(rootViewController: UIViewController()))
        let controller = factory.makeMediatingController(coordinator: coordinator) as! CredentialConfigureMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.generatePasswordBtn.sendActions(for: .touchUpInside)
        // then
        XCTAssertFalse(controller.passwordField.text!.isEmpty)
    }
    
    func testPasswordIsHidden() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: nil)
        let string = "password"
        // when
        controller.loadViewIfNeeded()
        controller.passwordField.text = string
        // then
        XCTAssertTrue(controller.passwordField.isSecureTextEntry)
    }
    
    func testPasswordIsShowing() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: nil)
        let string = "password"
        // when
        controller.loadViewIfNeeded()
        controller.passwordField.text = string
        controller.showPasswordBtn.sendActions(for: .touchUpInside)
        // then
        XCTAssertFalse(controller.passwordField.isSecureTextEntry)
    }
    
    func testCopyPasswordToClipboard() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: nil)
        let string = "password"
        // when
        controller.loadViewIfNeeded()
        controller.passwordField.text = string
        controller.copyPasswordBtn.sendActions(for: .touchUpInside)
        // then
        XCTAssertEqual(UIPasteboard.general.string, string)
        XCTAssertNotNil(controller.copyToClipboardConfirmationView)
    }
    
    func testPasswordChangeAlsoChangesPasswordFieldBackgroundColorIsRed() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: CredentialConfigureCoordinator(factory: CredentialConfigureFactory(), manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController()))
        let password = "password"
        // when
        controller.loadViewIfNeeded()
        controller.setPasswordTextField(with: password)
        // then
        XCTAssertEqual(controller.passwordField.backgroundColor, .red)
    }
    
    func testPasswordChangeAlsoChangesPasswordFieldBackgroundColorIsYellow() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: CredentialConfigureCoordinator(factory: CredentialConfigureFactory(), manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController()))
        let string = "1dpCl!dlsk432"
        // when
        controller.loadViewIfNeeded()
        controller.setPasswordTextField(with: string)
        // then
        XCTAssertEqual(controller.passwordField.backgroundColor, .yellow)
    }
    
    func testPasswordChangeAlsoChangesPasswordFieldBackgroundColorIsOrange() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: CredentialConfigureCoordinator(factory: CredentialConfigureFactory(), manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController()))
        let string = "1dpCl!dlsk"
        // when
        controller.loadViewIfNeeded()
        controller.setPasswordTextField(with: string)
        // then
        XCTAssertEqual(controller.passwordField.backgroundColor, .orange)
    }
    
    func testPasswordChangeAlsoChangesPasswordFieldBackgroundColorIsGreen() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: CredentialConfigureCoordinator(factory: CredentialConfigureFactory(), manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController()))
        let string = "1dpCl!dlsk432abcd"

        // when
        controller.loadViewIfNeeded()
        controller.setPasswordTextField(with: string)
        // then
        XCTAssertEqual(controller.passwordField.backgroundColor, .green)
    }
    
    func testPasswordSettingsShowingAndCloses() {
        // given
        let controller = CredentialConfigureMediatingController(delegate: CredentialConfigureCoordinator(factory: CredentialConfigureFactory(), manager: AccountCredentialsManager(), index: nil, navigation: UINavigationController()))

        // when
        controller.loadViewIfNeeded()
        controller.passwordSettingsBtn.sendActions(for: .touchUpInside)
        // then
        XCTAssertNotNil(controller.passwordSettingsView)
        XCTAssertNotNil(controller.shadowView)
        
        // when
        controller.passwordSettingsView?.closeButton.sendActions(for: .touchUpInside)
        // then
        XCTAssertNil(controller.passwordSettingsView)
        XCTAssertNil(controller.shadowView)
    }
    
    func testTableViewRowsMatchesNumberOfIdentifiers() {
        // given
        let manager = AccountCredentialsManager()
        var credentials = manager.fetchCredentials()
        // when
        credentials.append(AccountCredential(title: "title", username: "username", password: "password", identifiers: [
            "identifier1.com",
            "identifier2.com",
            "identifier3.com"
        ]))
        // then
        XCTAssertTrue(manager.storeCredentials(credentials))

        // given
        let lastCredentialIndex = credentials.endIndex-1
        let controller = CredentialConfigureMediatingController(delegate: CredentialConfigureCoordinator(factory: CredentialConfigureFactory(), manager: AccountCredentialsManager(), index: lastCredentialIndex, navigation: UINavigationController()))
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertEqual(controller.identifierTableView.numberOfRows(inSection: 0), credentials[lastCredentialIndex].identifiers.count)
    }
    
    func testDeletingIdentifierFromTableView() {
        // given
        let manager = AccountCredentialsManager()
        // when
        let newCredential = AccountCredential(title: "title", username: "username", password: "password", identifiers: [
            "identifier1.com",
            "identifier2.com",
            "identifier3.com"
        ])
        let credentials = [newCredential]
        // then
        XCTAssertTrue(manager.storeCredentials(credentials))
        
        // given
        let lastCredentialIndex = credentials.endIndex-1
        let controller = CredentialConfigureMediatingController(delegate: CredentialConfigureCoordinator(factory: CredentialConfigureFactory(), manager: AccountCredentialsManager(), index: lastCredentialIndex, navigation: UINavigationController()))
        // when
        controller.loadViewIfNeeded()
        guard let cell = controller.identifierTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? IdentifierTextFieldCell else {
            XCTFail("Cell is not IdentifierTextFieldCell")
            return
        }
        cell.deleteButton.sendActions(for: .touchUpInside)
        // then
        XCTAssertEqual(controller.identifierTableView.numberOfRows(inSection: 0), controller.identifiers.count)
    }
    
    func testEndEditingIdentifierChangesItInController() {
        // given
        let manager = AccountCredentialsManager()
        // when
        let newCredential = AccountCredential(title: "title", username: "username", password: "password", identifiers: [
            "identifier1.com",
            "identifier2.com",
            "identifier3.com"
        ])
        let credentials = [newCredential]
        // then
        XCTAssertTrue(manager.storeCredentials(credentials))
        
        // given
        let newIdentifier = "identifier4.com"
        let lastIdentifierIndex = credentials.last!.identifiers.endIndex-1
        let controller = CredentialConfigureMediatingController(delegate: CredentialConfigureCoordinator(factory: CredentialConfigureFactory(), manager: AccountCredentialsManager(), index: 0, navigation: UINavigationController()))
        // when
        controller.loadViewIfNeeded()
        guard let cell = controller.identifierTableView.cellForRow(at: IndexPath(row: lastIdentifierIndex, section: 0)) as? IdentifierTextFieldCell else {
            XCTFail("Cell is not IdentifierTextFieldCell")
            return
        }
        cell.identifierTextField.text = newIdentifier
        let _ = cell.textField(cell.identifierTextField, shouldChangeCharactersIn: NSRange(), replacementString: "")
        // then
        XCTAssertEqual(cell.identifierTextField.text, controller.identifiers.last)
    }
}
