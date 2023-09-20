//
//  Converter.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/9/23.
//

import Foundation

struct Converter {
    
    private let separator = "+"
    private let identifierSeparator = "*"
    
    private func stringArrayToData(_ stringArray: [String]) -> Data? {
      return try? JSONSerialization.data(withJSONObject: stringArray, options: [])
    }
    
    private func dataToStringArray(_ data: Data) -> [String]? {
      return (try? JSONSerialization.jsonObject(with: data, options: [])) as? [String]
    }
    
    private func anyObjectToData(_ data: Any) -> Data? {
        return try? JSONSerialization.data(withJSONObject: data, options: [])
    }
    
    private func dataArrayFrom(_ data: Data) -> [Data]? {
        return try? JSONSerialization.jsonObject(with: data, options: []) as? [Data]
    }
    
    private func credentialToString(_ credential: AccountCredential) -> String {
        var accountStringArray: [String] = []
        accountStringArray.append(credential.title)
        accountStringArray.append(credential.identifiers.joined(separator: self.identifierSeparator))
        accountStringArray.append(credential.decryptedUsername)
        accountStringArray.append(credential.decryptedPassword)
        return accountStringArray.joined(separator: separator)
    }
    
    private func stringToCredential(_ string: String) -> AccountCredential {
        let accountStringArray: [String] = string.components(separatedBy: separator)
        if accountStringArray.count < 4 {
            return AccountCredential(title: "title", username: "username", password: "password", identifiers: [])
        }
        let identifiers = accountStringArray[1].components(separatedBy: self.identifierSeparator)
        let credential = AccountCredential(title: accountStringArray[0], username: accountStringArray[2], password: accountStringArray[3], identifiers: identifiers)
        return credential
    }
    
    func credentialsToData(credentials: [AccountCredential]) -> Data? {
        var credentialStringArray: [String] = []
        for credential in credentials {
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted
            guard let credentialData = try? encoder.encode(credential), let credentialJSON = String(data: credentialData, encoding: .utf8) else {
                return nil
            }
            credentialStringArray.append(credentialJSON)
        }
        guard let credentialData = self.anyObjectToData(credentialStringArray) else {
            return nil
        }
        return credentialData
    }
    
    func dataToCredential(data: Data) -> [AccountCredential] {
        var credentials: [AccountCredential] = []
        guard let stringArray = self.dataToStringArray(data) else {
            return []
        }
        for string in stringArray {
            let decoder = JSONDecoder()
            if let data = string.data(using: .utf8), let credential = try? decoder.decode(AccountCredential.self, from: data) {
                credentials.append(credential)
            } else {
                credentials.append(self.stringToCredential(string))
            }
        }
        return credentials
    }
}
