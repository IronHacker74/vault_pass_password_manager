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
        XCTAssertNotNil(controller.lowerCaseSwitch)
        XCTAssertNotNil(controller.upperCaseSwitch)
        XCTAssertNotNil(controller.numbersSwitch)
        XCTAssertNotNil(controller.specialCharsSwitch)
        XCTAssertNotNil(controller.passwordLengthLabel)
        XCTAssertNotNil(controller.passwordLengthSlider)
        XCTAssertNotNil(controller.passwordStrengthColor)
    }
    
    func testPasswordSettingsSetFromManager() {
        // given
        let manager = AccountCredentialsManager()
        let factory = SettingsFactory()
        let navigation = UINavigationController(rootViewController: UIViewController())
        let controller = factory.makeMediatingController(manager: manager, navigation: navigation) as! SettingsMediatingController
        // when
        controller.loadViewIfNeeded()
        // then
        XCTAssertEqual(controller.lowerCaseSwitch.isOn, manager.useLowerCaseLetters)
        XCTAssertEqual(controller.upperCaseSwitch.isOn, manager.useUpperCaseLetters)
        XCTAssertEqual(controller.numbersSwitch.isOn, manager.useNumbers)
        XCTAssertEqual(controller.specialCharsSwitch.isOn, manager.useSpecialChars)
        XCTAssertEqual(controller.passwordLengthLabel.text, String(manager.passwordLength))
        XCTAssertEqual(Int(controller.passwordLengthSlider.value), manager.passwordLength)
    }
    
    func testLowerCaseSwitchIsReflectedInManager() {
        // given
        let manager = AccountCredentialsManager()
        let currentLowerCase = manager.useLowerCaseLetters
        let factory = SettingsFactory()
        let navigation = UINavigationController(rootViewController: UIViewController())
        let controller = factory.makeMediatingController(manager: manager, navigation: navigation) as! SettingsMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.lowerCaseSwitch.sendActions(for: .touchUpInside)
        // then
        XCTAssertNotEqual(currentLowerCase, manager.useLowerCaseLetters)
    }
    
    func testUpperCaseSwitchIsReflectedInManager() {
        // given
        let manager = AccountCredentialsManager()
        let currentUpperCase = manager.useUpperCaseLetters
        let factory = SettingsFactory()
        let navigation = UINavigationController(rootViewController: UIViewController())
        let controller = factory.makeMediatingController(manager: manager, navigation: navigation) as! SettingsMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.upperCaseSwitch.sendActions(for: .touchUpInside)
        // then
        XCTAssertNotEqual(currentUpperCase, manager.useUpperCaseLetters)
    }
    
    func testNumbersSwitchIsReflectedInManager() {
        // given
        let manager = AccountCredentialsManager()
        let currentNumbers = manager.useNumbers
        let factory = SettingsFactory()
        let navigation = UINavigationController(rootViewController: UIViewController())
        let controller = factory.makeMediatingController(manager: manager, navigation: navigation) as! SettingsMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.numbersSwitch.sendActions(for: .touchUpInside)
        // then
        XCTAssertNotEqual(currentNumbers, manager.useNumbers)
    }
    
    func testSpecialCaseSwitchIsReflectedInManager() {
        // given
        let manager = AccountCredentialsManager()
        let currentSpecialChars = manager.useSpecialChars
        let factory = SettingsFactory()
        let navigation = UINavigationController(rootViewController: UIViewController())
        let controller = factory.makeMediatingController(manager: manager, navigation: navigation) as! SettingsMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.specialCharsSwitch.sendActions(for: .touchUpInside)
        // then
        XCTAssertNotEqual(currentSpecialChars, manager.useSpecialChars)
    }
    
    func testPasswordLengthSliderChangeDoesChangeLengthInManager() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        let currentLength = manager.passwordLength
        let factory = SettingsFactory()
        let navigation = UINavigationController(rootViewController: UIViewController())
        let controller = factory.makeMediatingController(manager: manager, navigation: navigation) as! SettingsMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.passwordLengthSlider.setValue(16, animated: false)
        controller.passwordLengthSlider.sendActions(for: .valueChanged)
        // then
        XCTAssertNotEqual(currentLength, manager.passwordLength)
    }
    
    func testPasswordLengthSliderChangesLabel() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        let factory = SettingsFactory()
        let navigation = UINavigationController(rootViewController: UIViewController())
        let controller = factory.makeMediatingController(manager: manager, navigation: navigation) as! SettingsMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.passwordLengthSlider.setValue(16, animated: false)
        controller.passwordLengthSlider.sendActions(for: .valueChanged)
        // then
        XCTAssertEqual(Int(controller.passwordLengthSlider.value), Int(controller.passwordLengthLabel.text!))
    }
    
    func testPasswordStengthColorChanges() {
        // given
        let manager = AccountCredentialsManager()
        manager.setPasswordSettingsToDefault()
        let currentColor = manager.passwordStrengthColor()
        let factory = SettingsFactory()
        let navigation = UINavigationController(rootViewController: UIViewController())
        let controller = factory.makeMediatingController(manager: manager, navigation: navigation) as! SettingsMediatingController
        // when
        controller.loadViewIfNeeded()
        controller.lowerCaseSwitch.sendActions(for: .touchUpInside)
        controller.upperCaseSwitch.sendActions(for: .touchUpInside)
        controller.numbersSwitch.sendActions(for: .touchUpInside)
        controller.passwordLengthSlider.setValue(8, animated: false)
        controller.passwordLengthSlider.sendActions(for: .valueChanged)
        // then
        XCTAssertNotEqual(currentColor, manager.passwordStrengthColor())
        XCTAssertEqual(controller.passwordStrengthColor.backgroundColor!, manager.passwordStrengthColor())
    }
}
