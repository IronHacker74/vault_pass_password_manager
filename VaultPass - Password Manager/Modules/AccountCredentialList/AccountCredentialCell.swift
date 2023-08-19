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
}

class AccountCredentialCell: UITableViewCell, UIViewLoading {
    
    @IBOutlet private(set) var title: UILabel!
    @IBOutlet private(set) var username: UIButton!
    @IBOutlet private(set) var password: UIButton!
    @IBOutlet private(set) var credentialDisplayBtn: UIButton!
    
    private var delegate: AccountCredentialCellDelegate?
    var credential: AccountCredential?
    var index: Int?
    
    private let showImageString: String = "eye"
    private let hideImageString: String = "eye.slash"
    
    func configureCell(delegate: AccountCredentialCellDelegate?, credential: AccountCredential?, index: Int? = nil) {
        self.delegate = delegate
        self.credential = credential
        self.title.text = credential?.title
        self.index = index
        self.hideCredentials()
    }
    
    func credentialIsShowing() -> Bool {
        return self.username.isUserInteractionEnabled && self.password.isUserInteractionEnabled
    }
    
    func reveal() {
        self.username.showCredential(title: credential?.decryptedUsername)
        self.password.showCredential(title: credential?.decryptedPassword)
        self.credentialDisplayBtn.setImage(UIImage(systemName: self.hideImageString), for: .normal)
    }
    
    func hideCredentials() {
        self.username.hideCredential(placeHolder: "username")
        self.password.hideCredential(placeHolder: "password")
        self.credentialDisplayBtn.setImage(UIImage(systemName: self.showImageString), for: .normal)
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
    
    @IBAction func credentialDisplayTapped(_ sender: UIButton) {
        if credentialIsShowing() {
            self.hideCredentials()
        } else {
            self.reveal()
        }
    }
}
