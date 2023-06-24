//
//  TermsAndConditionsView.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/21/23.
//

import UIKit

class TermsAndConditionsMediatingController: UIViewController {
    
    @IBOutlet private(set) var titleLabel: UILabel!
    @IBOutlet private(set) var termsAndConditionsTextField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleText()
        self.setTermsAndConditionsText()
    }
    
    @IBAction func exitViewController(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func setTitleText() {
        self.titleLabel.text = "Terms and conditions of app use"
    }
    
    private func setTermsAndConditionsText() {
        self.termsAndConditionsTextField.text = self.termsAndConditions
    }
    
    private var termsAndConditions: String {
        return ""
    }
}
