//
//  AccountCredentialCell.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/7/23.
//

import UIKit

protocol AccountCredentialCellDelegate {
    func cellUsernameButtonTapped(credential: AccountCredential)
    func cellPasswordButtonTapped(credential: AccountCredential)
    func cellEditButtonTapped(index: Int)
}

class AccountCredentialCell: UITableViewCell, UIViewLoading {
    
    @IBOutlet private(set) var title: UILabel!
    @IBOutlet private(set) var username: UIButton!
    @IBOutlet private(set) var password: UIButton!
    @IBOutlet private(set) var revealLabel: UILabel!
    
    private var delegate: AccountCredentialCellDelegate?
    private var credential: AccountCredential?
    var index: Int!
    
    func configureCell(delegate: AccountCredentialCellDelegate?, credential: AccountCredential?, index: Int?) {
        self.delegate = delegate
        self.credential = credential
        self.title.text = credential?.title
        if let index {
            self.index = index
        }
        self.selectedBackgroundView?.backgroundColor = .systemBlue
    }
    
    func reveal() {
        self.username.setTitle(self.credential?.decryptedUsername, for: .normal)
        self.username.isUserInteractionEnabled = true
        self.password.setTitle(self.credential?.decryptedPassword, for: .normal)
        self.password.isUserInteractionEnabled = true
        self.revealLabel.isHidden = true
    }
    
    func hideCredentials() {
        self.username.setTitle("", for: .normal)
        self.username.isUserInteractionEnabled = false
        self.password.setTitle("", for: .normal)
        self.password.isUserInteractionEnabled = false
        self.revealLabel.isHidden = false
    }
    
    @IBAction func usernameButtonTapped(_ sender: UIButton) {
        guard let credential else {
            return
        }
        self.delegate?.cellUsernameButtonTapped(credential: credential)
    }
    
    @IBAction func passwordButtonTapped(_ sender: UIButton) {
        guard let credential else {
            return
        }
        self.delegate?.cellPasswordButtonTapped(credential: credential)
    }
    
    @IBAction func editButtonTapped(_ sender: UIButton) {
        guard let credential else {
            return
        }
        self.delegate?.cellEditButtonTapped(index: index)
    }
}
