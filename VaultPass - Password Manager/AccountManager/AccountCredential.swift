//
//  AccountCredential.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 4/3/23.
//


class AccountCredential {
    var title: String
    private var username: String // can also be email
    private var password: String // assumed encryption

    var dencryptedUsername: String {
        return username
    }
    var dencryptedPassword: String {
        return password // dencrypt the password everytime we want to return it.
    }

    init(title: String, username: String, password: String){
        self.title = title
        self.username = username
        self.password = password
    }
}

