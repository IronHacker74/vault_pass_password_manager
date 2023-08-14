//
//  PasswordSettingsView.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 8/12/23.
//

import UIKit

protocol PasswordSettingsDelegate {
    func setupPasswordSettings(displayable: SettingsDisplayable)
    func lowerCaseLettersSwitchChanged(displayable: SettingsDisplayable)
    func upperCaseLettersSwitchChanged(displayable: SettingsDisplayable)
    func numbersSwitchChanged(displayable: SettingsDisplayable)
    func specialCharSwitchChanged(displayable: SettingsDisplayable)
    func passwordLengthChanged(length: Int, displayable: SettingsDisplayable)
}

protocol SettingsDisplayable {
    func setOutlets(lowerCaseSwitch: Bool, upperCaseSwitch: Bool, numbersSwitch: Bool, specialCharsSwitch: Bool, passwordLength: Int)
    func changePasswordStrengthColor(_ color: UIColor)
}

class PasswordSettingsView: UIView, UIViewLoading {
    
    private var delegate: PasswordSettingsDelegate?
    
    @IBOutlet private(set) var passwordSettingsLabel: UILabel!
    @IBOutlet private(set) var lowerCaseSwitch: UISwitch!
    @IBOutlet private(set) var upperCaseSwitch: UISwitch!
    @IBOutlet private(set) var numbersSwitch: UISwitch!
    @IBOutlet private(set) var specialCharsSwitch: UISwitch!
    @IBOutlet private(set) var passwordLengthLabel: UILabel!
    @IBOutlet private(set) var passwordLengthSlider: UISlider!
    @IBOutlet private(set) var passwordStrengthColor: UIView!
    @IBOutlet private(set) var closeButton: UIButton!
    
    func setup(delegate: PasswordSettingsDelegate?, withCloseButton closeButtonEnabled: Bool = false) {
        self.delegate = delegate
        self.delegate?.setupPasswordSettings(displayable: self)
        self.setupPasswordStrengthColor()
        self.hideCloseButton(closeButtonEnabled)
    }
    
    private func setupPasswordStrengthColor() {
        self.passwordStrengthColor.layer.cornerRadius = 6
        self.passwordStrengthColor.layer.borderWidth = 3
        self.passwordStrengthColor.layer.borderColor = UIColor.secondarySystemBackground.cgColor
    }
    
    private func hideCloseButton(_ value: Bool) {
        self.closeButton.isHidden = !value
        self.closeButton.isUserInteractionEnabled = value
        
    }
    
    @IBAction func lowerCaseLettersSwitchTapped(_ lowerCaseSwitch: UISwitch) {
        self.delegate?.lowerCaseLettersSwitchChanged(displayable: self)
    }
    
    @IBAction func upperCaseLettersSwitchTapped(_ lettersSwitch: UISwitch) {
        self.delegate?.upperCaseLettersSwitchChanged(displayable: self)
    }
    
    @IBAction func numbersSwitchTapped(_ numbersSwitch: UISwitch) {
        self.delegate?.numbersSwitchChanged(displayable: self)
    }
    
    @IBAction func specialCharsSwitchTapped(_ specialCharsSwitch: UISwitch) {
        self.delegate?.specialCharSwitchChanged(displayable: self)
    }
    
    @IBAction func sliderDidChange(_ slider: UISlider) {
        self.passwordLengthLabel.text = "\(Int(slider.value))"
        self.delegate?.passwordLengthChanged(length: Int(slider.value), displayable: self)
    }

}

extension PasswordSettingsView: SettingsDisplayable {
    func changePasswordStrengthColor(_ color: UIColor) {
        self.passwordStrengthColor.backgroundColor = color
    }
    
    func setOutlets(lowerCaseSwitch: Bool, upperCaseSwitch: Bool, numbersSwitch: Bool, specialCharsSwitch: Bool, passwordLength: Int) {
        self.lowerCaseSwitch.setOn(lowerCaseSwitch, animated: false)
        self.upperCaseSwitch.setOn(upperCaseSwitch, animated: false)
        self.numbersSwitch.setOn(numbersSwitch, animated: false)
        self.specialCharsSwitch.setOn(specialCharsSwitch, animated: false)
        self.passwordLengthLabel.text = "\(passwordLength)"
        self.passwordLengthSlider.setValue(Float(passwordLength), animated: false)
    }
}
