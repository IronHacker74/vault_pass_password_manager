//
//  KeychainService.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 8/16/23.
//

import CryptoKit
import Foundation

class KeychainService {
    
    enum KeychainError: Error {
        case noItem
        case unexpectedKey
        case unhandledError(status: OSStatus)
    }
    
    static let standard = KeychainService()
    
    private let keychainServerLbl: String = "com.vaultpass.masters.keychain.label.key"
    private let searchQuery: [String: Any]
    private var baseQuery: [String: Any]

    init() {
        let query: [String: Any] = [kSecClass as String: kSecClassGenericPassword,
                     kSecAttrLabel as String: self.keychainServerLbl,
                     kSecAttrSynchronizable as String: true]
        var searchQuery: [String: Any] = query
        searchQuery[kSecReturnAttributes as String] = true
        searchQuery[kSecReturnData as String] = true
        
        self.baseQuery = query
        self.searchQuery = searchQuery
    }
    
    func saveKey(_ key: SymmetricKey) {
        let keyData = key.withUnsafeBytes{Data(Array($0))}
        var query: [String: Any] = self.baseQuery
        query[kSecValueData as String] = keyData

        let status = SecItemAdd(query as CFDictionary, nil)
        guard status == errSecSuccess else {
            print(KeychainError.unhandledError(status: status))
            return
        }
    }
    
    func deleteKey() {
        let status = SecItemDelete(self.searchQuery as CFDictionary)
        guard status == errSecSuccess || status == errSecItemNotFound else {
            print(KeychainError.unhandledError(status: status))
            return
        }
    }
    
    func fetchKey() -> Data? {
        var item: CFTypeRef?
        let status = SecItemCopyMatching(self.searchQuery as CFDictionary, &item)
        guard status != errSecItemNotFound else {
            print(KeychainError.noItem)
            return nil
        }
        guard status == errSecSuccess else {
            print(KeychainError.unhandledError(status: status))
            return nil
        }
        
        guard let existingItem = item as? [String: Any],
            let keyData = existingItem[kSecValueData as String] as? Data
        else {
            print(KeychainError.unexpectedKey)
            return self.updateKey()
        }
        return keyData
    }
    
    private func updateKey() -> Data? {
        let key = SymmetricKey(size: .bits256)
        let keyData = key.withUnsafeBytes{Data(Array($0))}
        let attributes: [String: Any] = [kSecValueData as String: keyData]

        let status = SecItemUpdate(self.baseQuery as CFDictionary, attributes as CFDictionary)
        guard status != errSecItemNotFound else {
            print(KeychainError.noItem)
            return nil
        }
        guard status == errSecSuccess else {
            print(KeychainError.unhandledError(status: status))
            return nil
        }
        return keyData
    }
}
