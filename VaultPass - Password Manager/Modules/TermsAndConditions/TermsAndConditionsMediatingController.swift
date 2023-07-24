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
    @IBOutlet private(set) var exitButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTitleText()
        self.setTermsAndConditionsText()
    }
    
    @IBAction func exitViewController(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    private func setTitleText() {
        self.titleLabel.text = "Terms and Conditions"
    }
    
    private func setTermsAndConditionsText() {
        self.termsAndConditionsTextField.text = self.termsAndConditions
    }
    
    private var termsAndConditions: String {
        let path = Bundle.main.path(forResource: "TermsAndConditions", ofType: ".txt")
        guard let path, let text = try? String(contentsOfFile: path, encoding: .utf8) else {
            CustomAlert.ok(self, title: "Oops!", message: "Failed to load terms and conditions!", style: .alert)
            return ""
        }
        return text
    }
}
