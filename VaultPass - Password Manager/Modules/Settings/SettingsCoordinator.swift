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
    
    func logoutButtonPressed() {
        let alertController = UIAlertController(title: "Logout?", message: "Are you sure you want to logout?", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel) {_ in
            alertController.dismiss(animated: true)
        })
        alertController.addAction(UIAlertAction(title: "Yes", style: .default) {_ in
            let factory = LoginFactory()
            let controller = LoginMediatingController.loadFromNibMain()
            controller.delegate = factory.makeCoordinator(navigation: UINavigationController())
            UIApplication.shared.windows.first?.rootViewController = controller
            UIApplication.shared.windows.first?.makeKeyAndVisible()
        })
        self.navigation.present(alertController, animated: true)
    }
    
    func deleteAllData() {
        self.credentialsManager.deleteStore()
        self.navigation.popViewController(animated: true)
    }
}
