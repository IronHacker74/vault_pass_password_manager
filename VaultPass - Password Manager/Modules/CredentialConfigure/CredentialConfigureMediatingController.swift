//
//  CredentialConfigureMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/12/23.
//

import UIKit

protocol CredentialConfigureDelegate {
    func saveCredentialToStore(_ controller: UIViewController, title: String, username: String, password: String)
    func generatePassword() -> String
}

class CredentialConfigureMediatingController: UIViewController {
    
    @IBOutlet private(set) var titleField: UITextField!
    @IBOutlet private(set) var usernameField: UITextField!
    @IBOutlet private(set) var passwordField: UITextField!
    
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
        self.navigationItem.title = "Credential Configuration"
    }
    
    @IBAction func generatePasswordBtnPressed(_ sender: UIButton) {
        guard let newPassword = self.delegate?.generatePassword() else {
            // TODO: show error
            return
        }
        self.passwordField.text = newPassword
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        guard let title = self.titleField.text, let username = self.usernameField.text, let password = self.passwordField.text else {
            // TODO: show error
            return
        }
        self.delegate?.saveCredentialToStore(self, title: title, username: username, password: password)
    }
}
