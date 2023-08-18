//
//  Encryptor.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/9/23.
//

import CryptoKit
import Foundation

struct Encryptor {
    
    static let standard = Encryptor()
        
    private func fetchKey() -> SymmetricKey {
        guard let keyData = KeychainService.standard.fetchKey() else {
            let key = SymmetricKey(size: .bits256)
            KeychainService.standard.saveKey(key)
            return key
        }
        return SymmetricKey(data: keyData)
    }
    
    func encrypt(data: Data) -> Data? {
        if let cryptedBox = try? ChaChaPoly.seal(data, using: self.fetchKey()),
           let sealedBox = try? ChaChaPoly.SealedBox(combined: cryptedBox.combined) {
            return sealedBox.combined
        }
        print("Failed to encrypt")
        return nil
    }
    
    func decrypt(data: Data) -> Data? {
        if let sealedBoxToOpen = try? ChaChaPoly.SealedBox(combined: data),
           let decryptedData = try? ChaChaPoly.open(sealedBoxToOpen, using: self.fetchKey()) {
           return decryptedData
        }
        print("Failed to decrypt")
        return nil
    }

    func encryptStringData(_ string: String) -> Data {
        guard let encryptedData = string.data(using: .utf8) else {
            return Data()
        }
        return self.encrypt(data: encryptedData) ?? Data()
    }
    
    func decryptStringData(_ data: Data) -> String {
        guard let decryptedData = self.decrypt(data: data) else {
            return "nil"
        }
        return String(data: decryptedData, encoding: .utf8) ?? "nil"
    }
}
