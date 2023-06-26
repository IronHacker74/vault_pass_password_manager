//
//  CredentialConfigureMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/12/23.
//

import UIKit

protocol CredentialConfigureDelegate {
    func credentialConfigureViewDidLoad(displayable: CredentialConfigureDisplayable)
    func credentialConfigureViewWillDisappear()
    func saveCredential(title: String, username: String, password: String)
    func generatePassword() -> String
    func passwordSettingsPressed()
    func deleteButtonPressed()
}

protocol CredentialConfigureDisplayable {
    func fillFields(with credential: AccountCredential)
    func hideDeleteButton()
}

class CredentialConfigureMediatingController: UIViewController {
    
    @IBOutlet private(set) var titleField: UITextField!
    @IBOutlet private(set) var usernameField: UITextField!
    @IBOutlet private(set) var passwordField: UITextField!
    @IBOutlet private(set) var errorLabel: UILabel!
    @IBOutlet private(set) var passwordSettingsBtn: UIButton!
    @IBOutlet private(set) var generatePasswordBtn: UIButton!
    @IBOutlet private(set) var saveButton: UIButton!
    @IBOutlet private(set) var deleteBtn: UIButton!
    
    let delegate: CredentialConfigureDelegate?
    
    init(delegate: CredentialConfigureDelegate?) {
        self.delegate = delegate
        super.init(nibName: "CredentialConfigureMediatingController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        self.delegate = nil
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate?.credentialConfigureViewDidLoad(displayable: self)
        self.navigationItem.title = "Credential Configuration"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.delegate?.credentialConfigureViewWillDisappear()
    }
    
    @IBAction func passwordSettingsBtnPressed(_ sender: UIButton) {
        self.delegate?.passwordSettingsPressed()
    }
    
    @IBAction func generatePasswordBtnPressed(_ sender: UIButton) {
        guard let newPassword = self.delegate?.generatePassword(), !newPassword.isEmpty else {
            self.showError("Password failed to generate")
            return
        }
        self.hideErrorIfNeeded()
        self.passwordField.text = newPassword
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let title = self.titleField.text, !title.isEmpty else {
            self.showError("Title required")
            return
        }
        guard let username = self.usernameField.text, let password = self.passwordField.text, (!username.isEmpty || !password.isEmpty) else {
            self.showError("Username or password is required")
            return
        }
        self.delegate?.saveCredential(title: title, username: username, password: password)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        self.delegate?.deleteButtonPressed()
    }
    
    private func showError(_ error: String){
        self.errorLabel.text = error
        if self.errorLabel.isHidden {
            self.errorLabel.isHidden = false
        }
    }
    
    private func hideErrorIfNeeded() {
        if self.errorLabel.isHidden == false {
            self.errorLabel.isHidden = true
        }
    }
}

extension CredentialConfigureMediatingController: CredentialConfigureDisplayable {
    func fillFields(with credential: AccountCredential) {
        self.titleField.text = credential.title
        self.usernameField.text = credential.decryptedUsername
        self.passwordField.text = credential.decryptedPassword
    }
    
    func hideDeleteButton() {
        self.deleteBtn.isHidden = true
    }
}

extension CredentialConfigureMediatingController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.hideErrorIfNeeded()
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
    }
}
