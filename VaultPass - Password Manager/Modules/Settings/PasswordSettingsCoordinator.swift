//
//  PasswordSettingsCoordinator.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 8/12/23.
//


class PasswordSettingsCoordinator: PasswordSettingsDelegate {
    
    let credentialsManager: AccountCredentialsManager
    
    init(credentialsManager: AccountCredentialsManager) {
        self.credentialsManager = credentialsManager
    }
    
    func setupPasswordSettings(displayable: SettingsDisplayable) {
        let lowerCaseSwitch = credentialsManager.useLowerCaseLetters
        let upperCaseSwitch = credentialsManager.useUpperCaseLetters
        let numbersSwtich = credentialsManager.useNumbers
        let specialCharsSwitch = credentialsManager.useSpecialChars
        let passwordLength = credentialsManager.passwordLength
        let passwordStrength =  credentialsManager.passwordStrengthColor()
        displayable.setOutlets(lowerCaseSwitch: lowerCaseSwitch, upperCaseSwitch: upperCaseSwitch, numbersSwitch: numbersSwtich, specialCharsSwitch: specialCharsSwitch, passwordLength: passwordLength)
        displayable.changePasswordStrengthColor(passwordStrength)
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
}
