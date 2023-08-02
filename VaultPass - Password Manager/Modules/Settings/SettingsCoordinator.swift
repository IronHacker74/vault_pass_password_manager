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
    let unlockData: UnlockData = UnlockData()
    
    init(credentialsManager: AccountCredentialsManager, navigation: UINavigationController) {
        self.credentialsManager = credentialsManager
        self.navigation = navigation
    }
    
    func settingsMediatingControllerViewDidLoad(displayable: SettingsDisplayable) {
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
    
    func termsAndConditionsTapped() {
        let factory = TermsAndConditionsFactory()
        let controller = factory.makeMediatingController()
        self.navigation.present(controller, animated: true)
    }
    
    func unlockButtonPressed() {
        CustomAlert.destructive(self.navigation, title: "Lock your credentials?", message: "Are you sure you want to relock your data?", style: .actionSheet, deleteBtn: "Lock", deleteAction: { _ in
            self.unlockData.setAutoUnlock(false)
            let factory = UnlockFactory()
            let controller = UnlockMediatingController.loadFromNibMain()
            controller.delegate = factory.makeCoordinator(navigation: UINavigationController())
            UIApplication.shared.windows.first?.rootViewController = controller
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        })
    }
    
    func deleteAllData() {
        CustomAlert.destructive(self.navigation, title: "Are you sure you want to delete all credentials?", message: "This action is irreversible and will be permanent", style: .alert, deleteBtn: "Delete", deleteAction: { _ in
            self.credentialsManager.deleteAllData()
            self.unlockData.deleteData()
            self.navigation.popViewController(animated: true)
        })
    }
}
