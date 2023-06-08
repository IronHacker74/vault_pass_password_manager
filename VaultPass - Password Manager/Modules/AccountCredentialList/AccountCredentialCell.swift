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
    
    func configureCell(title: String) {
        self.title.text = title
    }
    
    func reveal(username: String, password: String) {
        self.username.text = username
        self.password.text = password
    }
}
