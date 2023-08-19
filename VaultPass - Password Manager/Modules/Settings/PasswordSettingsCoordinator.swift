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
    
    func setupPasswordSettings(displayable: PasswordSettingsDisplayable) {
        let lowerCaseSwitch = credentialsManager.useLowerCaseLetters
        let upperCaseSwitch = credentialsManager.useUpperCaseLetters
        let numbersSwtich = credentialsManager.useNumbers
        let specialCharsSwitch = credentialsManager.useSpecialChars
        let passwordLength = credentialsManager.passwordLength
        let passwordStrength =  credentialsManager.passwordStrengthColor()
        displayable.setOutlets(lowerCaseSwitch: lowerCaseSwitch, upperCaseSwitch: upperCaseSwitch, numbersSwitch: numbersSwtich, specialCharsSwitch: specialCharsSwitch, passwordLength: passwordLength)
        displayable.changePasswordStrengthColor(passwordStrength)
    }
    
    func lowerCaseLettersSwitchChanged(displayable: PasswordSettingsDisplayable) {
        self.credentialsManager.toggleStringType(of: .lowerCase)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func upperCaseLettersSwitchChanged(displayable: PasswordSettingsDisplayable) {
        self.credentialsManager.toggleStringType(of: .upperCase)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func numbersSwitchChanged(displayable: PasswordSettingsDisplayable) {
        self.credentialsManager.toggleStringType(of: .numbers)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func specialCharSwitchChanged(displayable: PasswordSettingsDisplayable) {
        self.credentialsManager.toggleStringType(of: .specialChar)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func passwordLengthChanged(length: Int, displayable: PasswordSettingsDisplayable) {
        self.credentialsManager.changePasswordLength(length)
        self.passwordSettingsChanged(displayable: displayable)
    }
    
    func passwordSettingsChanged(displayable: PasswordSettingsDisplayable) {
        let passwordStrengthColor = self.credentialsManager.passwordStrengthColor()
        displayable.changePasswordStrengthColor(passwordStrengthColor)
    }
}
