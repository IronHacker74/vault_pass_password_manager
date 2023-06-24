//
//  Converter.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/9/23.
//

import Foundation

struct Converter {
    
    private let separator = "+"
    
    func stringArrayToData(_ stringArray: [String]) -> Data? {
      return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
    }
    
    func dataToStringArray(_ data: Data) -> [String]? {
      return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String]
    }
    
    func credentialToString(_ credential: AccountCredential) -> String {
        var accountStringArray: [String] = []
        accountStringArray.append(credential.title)
        accountStringArray.append(credential.decryptedUsername)
        accountStringArray.append(credential.decryptedPassword)
        return accountStringArray.joined(separator: separator)
    }
    
    func stringToCredential(_ string: String) -> AccountCredential {
        let accountStringArray: [String] = string.components(separatedBy: separator)
        let credential = AccountCredential(title: accountStringArray[0], username: accountStringArray[1], password: accountStringArray[2])
        return credential
    }
}
