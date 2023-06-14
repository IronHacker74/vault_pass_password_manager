//
//  AccountCredentialCell.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/7/23.
//

import UIKit

class AccountCredentialCell: UITableViewCell {
    
    @IBOutlet private(set) var title: UILabel!
    @IBOutlet private(set) var username: UILabel!
    @IBOutlet private(set) var password: UILabel!
    @IBOutlet private(set) var revealLabel: UILabel!
    
    func configureCell(title: String) {
        self.title.text = title
        self.selectedBackgroundView?.backgroundColor = .systemBlue
    }
    
    func reveal(credential: AccountCredential) {
        self.username.text = credential.decryptedUsername
        self.password.text = credential.decryptedPassword
        self.revealLabel.isHidden = true
    }
}
