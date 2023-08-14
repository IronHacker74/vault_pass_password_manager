//
//  SettingsMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/14/23.
//

import Foundation
import UIKit

protocol SettingsDelegate: PasswordSettingsDelegate {
    func termsAndConditionsTapped()
    func lockButtonPressed()
    func deleteAllData()
}

class SettingsMediatingController: UIViewController {
    
    @IBOutlet private(set) var passwordSettingsParentView: UIView!
    
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
            passwordSettingsView.trailingAnchor.constraint(equalTo: self.passwordSettingsParentView.trailingAnchor),
            passwordSettingsView.leadingAnchor.constraint(equalTo: self.passwordSettingsParentView.leadingAnchor),
            passwordSettingsView.topAnchor.constraint(equalTo: self.passwordSettingsParentView.topAnchor),
            passwordSettingsView.bottomAnchor.constraint(equalTo: self.passwordSettingsParentView.bottomAnchor),
        ])
        passwordSettingsView.setup(delegate: self.delegate, withCloseButton: false)
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
