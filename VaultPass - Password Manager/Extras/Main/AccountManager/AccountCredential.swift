//
//  AccountCredential.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 4/3/23.
//

import Foundation
import CoreData
import AuthenticationServices

class AccountCredential: Equatable, Codable {
    
    let title: String
    var identifiers: [String]
    private let username: Data
    private let password: Data
    
    var decryptedUsername: String {
        return Encryptor.standard.decryptStringData(self.username)
    }
    var decryptedPassword: String {
        return Encryptor.standard.decryptStringData(self.password)
    }

    init(title: String, username: String, password: String, identifiers: [String]){
        self.title = title
        self.username = Encryptor.standard.encryptStringData(username)
        self.password = Encryptor.standard.encryptStringData(password)
        self.identifiers = identifiers
    }
    
    static func == (lhs: AccountCredential, rhs: AccountCredential) -> Bool {
        return lhs.title == rhs.title && lhs.identifiers == rhs.identifiers && lhs.decryptedUsername == rhs.decryptedUsername && lhs.decryptedPassword == rhs.decryptedPassword
    }
    
    func passwordCredential() -> ASPasswordCredential {
        return ASPasswordCredential(user: self.decryptedUsername, password: self.decryptedPassword)
    }
    
    func findMatchFor(_ identifier: String) -> Bool {
        for myIdentifier in self.identifiers {
            if identifier.contains(myIdentifier) {
                return true
            }
        }
        return false
    }
}


extension AccountCredential {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EncryptedCredentials> {
        return NSFetchRequest<EncryptedCredentials>(entityName: "EncryptedCredentials")
    }
    @NSManaged public var credentials: Data?
}
