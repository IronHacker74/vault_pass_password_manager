//
//  SettingsMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/14/23.
//

import Foundation
import UIKit

protocol SettingsDelegate: PasswordSettingsDelegate {
    func settingsControllerViewDidLoad(_ displayable: SettingsDisplayable)
    func toggleAutoUnlock()
    func termsAndConditionsTapped()
    func lockButtonPressed()
    func deleteAllData()
}

protocol SettingsDisplayable {
    func setAutoUnlockSwitch(_ value: Bool)
}

class SettingsMediatingController: UIViewController {
    
    @IBOutlet private(set) var passwordSettingsParentView: UIView!
    @IBOutlet private(set) var autoUnlockLabel: UILabel!
    @IBOutlet private(set) var autoUnlockSwitch: UISwitch!
    @IBOutlet private(set) var enableAutofillBtn: UIButton!
    
    @IBOutlet private(set) var termsAndConditionsBtn: UIButton!
    @IBOutlet private(set) var privacyPolicyBtn: UIButton!
    @IBOutlet private(set) var deleteAllDataBtn: UIButton!
    @IBOutlet private(set) var padConstraints: [NSLayoutConstraint]! {
        didSet {
            PadConstraints.setLeadingTrailingConstraints(self.padConstraints)
        }
    }
    
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
        self.delegate?.settingsControllerViewDidLoad(self)
        self.setupPasswordSettingsView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = "Settings"
        self.navigationItem.backBarButtonItem?.title = "Back"
    }
        
    private func setupPasswordSettingsView() {
        let passwordSettingsView: PasswordSettingsView = PasswordSettingsView.initFromNib()
        self.passwordSettingsParentView.addSubview(passwordSettingsView)
        passwordSettingsView.translatesAutoresizingMaskIntoConstraints = false
        passwordSettingsView.center = passwordSettingsParentView.center
        NSLayoutConstraint.activate([
            passwordSettingsView.trailingAnchor.constraint(equalTo: self.passwordSettingsParentView.trailingAnchor, constant: 8),
            passwordSettingsView.leadingAnchor.constraint(equalTo: self.passwordSettingsParentView.leadingAnchor, constant: -8),
            passwordSettingsView.topAnchor.constraint(equalTo: self.passwordSettingsParentView.topAnchor),
            passwordSettingsView.bottomAnchor.constraint(equalTo: self.passwordSettingsParentView.bottomAnchor),
        ])
        passwordSettingsView.setup(delegate: self.delegate, withCloseButton: false)
    }
    
    @IBAction func autoUnlockSwitched(_ sender: UISwitch) {
        self.delegate?.toggleAutoUnlock()
    }
    
    @IBAction func enableAutofillBtnTapped(_ sender: UIButton) {
        OpenAppLink.using(.autofill, vc: self)
    }
    
    @IBAction func termsAndConditionsPressed(_ sender: UIButton) {
        OpenAppLink.using(.termsAndConditions, vc: self)
    }
    
    @IBAction func privacyPolicyPressed(_ sender: UIButton) {
        OpenAppLink.using(.privacyPolicy, vc: self)
    }
    
    @IBAction func lockBtnPressed(_ sender: UIButton) {
        self.delegate?.lockButtonPressed()
    }
    
    @IBAction func deleteAllDataBtnPressed(_ sender: UIButton) {
        self.delegate?.deleteAllData()
    }
}


extension SettingsMediatingController: SettingsDisplayable {
    func setAutoUnlockSwitch(_ value: Bool) {
        self.autoUnlockSwitch.setOn(value, animated: false)
    }
}
