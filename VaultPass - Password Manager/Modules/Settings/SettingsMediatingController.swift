//
//  SettingsMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/14/23.
//

import Foundation
import UIKit

protocol SettingsDelegate {
    func settingsMediatingControllerViewDidLoad(displayable: SettingsDisplayable)
    func lowerCaseLettersSwitchChanged(displayable: SettingsDisplayable)
    func upperCaseLettersSwitchChanged(displayable: SettingsDisplayable)
    func numbersSwitchChanged(displayable: SettingsDisplayable)
    func specialCharSwitchChanged(displayable: SettingsDisplayable)
    func passwordLengthChanged(length: Int, displayable: SettingsDisplayable)
    func termsAndConditionsTapped()
    func logoutButtonPressed()
    func deleteAllData()
}

protocol SettingsDisplayable {
    func setOutlets(lowerCaseSwitch: Bool, upperCaseSwitch: Bool, numbersSwitch: Bool, specialCharsSwitch: Bool, passwordLength: Int)
    func changePasswordStrengthColor(_ color: UIColor)
}

class SettingsMediatingController: UIViewController {
    
    @IBOutlet private(set) var lowerCaseSwitch: UISwitch!
    @IBOutlet private(set) var upperCaseSwitch: UISwitch!
    @IBOutlet private(set) var numbersSwitch: UISwitch!
    @IBOutlet private(set) var specialCharsSwitch: UISwitch!
    
    @IBOutlet private(set) var passwordLengthLabel: UILabel!
    @IBOutlet private(set) var passwordLengthSlider: UISlider!
    @IBOutlet private(set) var passwordStrengthColor: UIView!
    
    @IBOutlet private(set) var termsAndConditionsBtn: UIButton!
    @IBOutlet private(set) var privacyPolicyBtn: UIButton!
    @IBOutlet private(set) var deleteAllDataBtn: UIButton!
    
    var delegate: SettingsDelegate?
    
    init(delegate: SettingsDelegate?) {
        self.delegate = delegate
        super.init(nibName: "SettingsMediatingController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.delegate = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.settingsMediatingControllerViewDidLoad(displayable: self)
        self.setupPasswordStrengthColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Settings"
        self.navigationItem.backBarButtonItem?.title = "Back"
    }
    
    private func setupPasswordStrengthColor() {
        self.passwordStrengthColor.layer.cornerRadius = 6
        self.passwordStrengthColor.layer.borderWidth = 3
        self.passwordStrengthColor.layer.borderColor = UIColor.secondarySystemBackground.cgColor
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
    
    @IBAction func termsAndConditionsPressed(_ sender: UIButton) {
        OpenAppLink.using(.termsAndConditions, vc: self)
    }
    
    @IBAction func privacyPolicyPressed(_ sender: UIButton) {
        OpenAppLink.using(.privacyPolicy, vc: self)
    }
    
    @IBAction func logoutBtnPressed(_ sender: UIButton) {
        self.delegate?.logoutButtonPressed()
    }
    
    @IBAction func deleteAllDataBtnPressed(_ sender: UIButton) {
        self.delegate?.deleteAllData()
    }
}

extension SettingsMediatingController: SettingsDisplayable {
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
