//
//  AccountCredential.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 4/3/23.
//

import Foundation

class AccountCredential: Equatable {
    
    let title: String
    let identifier: String
    private let username: Data
    private let password: Data
    
    var decryptedUsername: String {
        return Encryptor.standard.decryptStringData(self.username)
    }
    var decryptedPassword: String {
        return Encryptor.standard.decryptStringData(self.password)
    }

    init(title: String, identifier: String, username: String, password: String){
        self.title = title
        self.identifier = identifier
        self.username = Encryptor.standard.encryptStringData(username)
        self.password = Encryptor.standard.encryptStringData(password)
    }
    
    static func == (lhs: AccountCredential, rhs: AccountCredential) -> Bool {
        return lhs.title == rhs.title && lhs.identifier == rhs.identifier && lhs.decryptedUsername == rhs.decryptedUsername && lhs.decryptedPassword == rhs.decryptedPassword
    }
}

