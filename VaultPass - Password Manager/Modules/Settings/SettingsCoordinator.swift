//
//  SettingsCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/14/23.
//

import UIKit

class SettingsCoordinator: SettingsDelegate {
    
    let credentialsManager: AccountCredentialsManager
    let navigation: UINavigationController
    
    init(credentialsManager: AccountCredentialsManager, navigation: UINavigationController) {
        self.credentialsManager = credentialsManager
        self.navigation = navigation
    }
    
    func lowerCaseLettersSwitchChanged(displayable: SettingsDisplayable) {
        self.credentialsManager.toggleStringType(of: .lowerCase)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func upperCaseLettersSwitchChanged(displayable: SettingsDisplayable) {
        self.credentialsManager.toggleStringType(of: .upperCase)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func numbersSwitchChanged(displayable: SettingsDisplayable) {
        self.credentialsManager.toggleStringType(of: .numbers)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func specialCharSwitchChanged(displayable: SettingsDisplayable) {
        self.credentialsManager.toggleStringType(of: .specialChar)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func passwordLengthChanged(length: Int, displayable: SettingsDisplayable) {
        self.credentialsManager.changePasswordLength(length)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func passwordSettingsChanged(displayable: SettingsDisplayable) {
        let passwordStrengthColor = self.credentialsManager.passwordStrengthColor()
        displayable.changePasswordStrengthColor(passwordStrengthColor)
    }
    
    func termsAndConditionsTapped() {
        // TODO: push terms and conditions controller
    }
    
    func deleteAllData() {
        self.credentialsManager.deleteStore()
        self.navigation.popViewController(animated: true)
    }
    
    func settingsMediatingControllerViewDidLoad(displayable: SettingsDisplayable) {
        let lowerCaseSwitch = credentialsManager.useLowerCaseLetters
        let upperCaseSwitch = credentialsManager.useUpperCaseLetters
        let numbersSwtich = credentialsManager.useNumbers
        let specialCharsSwitch = credentialsManager.useSpecialChars
        let passwordLength = credentialsManager.passwordLength
        displayable.setOutlets(lowerCaseSwitch: lowerCaseSwitch, upperCaseSwitch: upperCaseSwitch, numbersSwitch: numbersSwtich, specialCharsSwitch: specialCharsSwitch, passwordLength: passwordLength)
    }
}
