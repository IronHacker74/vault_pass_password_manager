//
//  AccountCredentialsManager.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/7/23.
//

import UIKit
import CoreData
import AuthenticationServices

enum PasswordStringType {
    case lowerCase
    case upperCase
    case numbers
    case specialChar
}

enum PasswordStrength {
    case none
    case bad
    case okay
    case good
    case best
}

struct AccountCredentialsManager {
    let context: NSManagedObjectContext
    private let converter: Converter = Converter()
    private let modelName = "Model"
    
    private let lowerCaseKey = "lower_case_key"
    private let upperCaseKey = "upper_case_key"
    private let numbersKey = "numbers_key"
    private let specialCharKey = "special_char_key"
    private let passwordLengthKey = "password_length_key"
    private let userDefaults = UserDefaults(suiteName: "group.vaultpass.masters")
    
    private let lowerCaseLetters: String = "abcdefghijklmnopqrstuvwxyz"
    private let upperCaseLetters: String = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    private let allNumbers: String = "1234567890"
    private let allSpecialChars: String = ".!@#$*"
    
    var useLowerCaseLetters: Bool {
        return (self.userDefaults?.bool(forKey: self.lowerCaseKey) ?? true)
    }
    var useUpperCaseLetters: Bool {
        return (self.userDefaults?.bool(forKey: self.upperCaseKey) ?? true)
    }
    var useNumbers: Bool {
        return (self.userDefaults?.bool(forKey: self.numbersKey) ?? true)
    }
    var useSpecialChars: Bool {
        return (self.userDefaults?.bool(forKey: self.specialCharKey) ?? true)
    }
    var passwordLength: Int {
        return (self.userDefaults?.integer(forKey: self.passwordLengthKey) ?? 12)
    }
    
    private func lowerCase() -> String {
        return self.useLowerCaseLetters ? self.lowerCaseLetters : ""
    }
    
    private func upperCase() -> String {
        return self.useUpperCaseLetters ? self.upperCaseLetters : ""
    }

    private func numbers() -> String {
        return self.useNumbers ? self.allNumbers : ""
    }
    
    private func specialChars() -> String {
        return self.useSpecialChars ? self.allSpecialChars : ""
    }
    
    init() {
        guard let url = Bundle.main.url(forResource: modelName, withExtension: "momd"), let model = NSManagedObjectModel(contentsOf: url) else {
            self.context = DefaultContainer().persistentContainer.viewContext
            return
        }
        self.context = PersistentContainer(name: modelName, managedObjectModel: model).viewContext
    }
    
    func setPasswordSettingsToDefault() {
        self.userDefaults?.set(true, forKey: self.specialCharKey)
        self.userDefaults?.set(true, forKey: self.numbersKey)
        self.userDefaults?.set(true, forKey: self.upperCaseKey)
        self.userDefaults?.set(true, forKey: self.lowerCaseKey)
        self.userDefaults?.set(12, forKey: self.passwordLengthKey)
    }
    
    func toggleStringType(of type: PasswordStringType) {
        switch type {
        case .lowerCase:
            changePasswordStringType(for: self.useLowerCaseLetters, withKey: self.lowerCaseKey)
        case .upperCase:
            changePasswordStringType(for: self.useUpperCaseLetters, withKey: self.upperCaseKey)
        case .numbers:
            changePasswordStringType(for: self.useNumbers, withKey: self.numbersKey)
        case .specialChar:
            changePasswordStringType(for: self.useSpecialChars, withKey: self.specialCharKey)
        }
    }
    
    func changePasswordLength(_ length: Int){
        self.userDefaults?.set(length, forKey: self.passwordLengthKey)
    }
    
    private func changePasswordStringType(for currentValue: Bool, withKey key: String) {
        let newValue = currentValue ? false : true
        self.userDefaults?.set(newValue, forKey: key)
    }
    
    func generatePassword() -> String {
        let length = passwordLength
        let passwordCharacters = lowerCase() + upperCase() + numbers() + specialChars()
        let newPassword = String((0..<length).compactMap{ _ in passwordCharacters.randomElement() })
        return newPassword
    }
    
    private func numberOfPasswordStringTypesEnabled() -> Int {
        var stringTypesEnabled: Int = 0
        if self.useLowerCaseLetters {
            stringTypesEnabled = stringTypesEnabled + 1
        }
        if self.useUpperCaseLetters {
            stringTypesEnabled = stringTypesEnabled + 1
        }
        if self.useNumbers {
            stringTypesEnabled = stringTypesEnabled + 1
        }
        if self.useSpecialChars {
            stringTypesEnabled = stringTypesEnabled + 1
        }
        return stringTypesEnabled
    }
    
    func passwordStrength(stringTypes: Int = 0, passwordLength: Int = 0) -> PasswordStrength {
        let stringTypesEnabled = stringTypes == 0 ? self.numberOfPasswordStringTypesEnabled() : stringTypes
        let passwordLength = passwordLength == 0 ? self.passwordLength : passwordLength
        var type: PasswordStrength = .none
        if passwordLength <= 10 {
            if stringTypesEnabled == 0 {
                type = .none
            } else if stringTypesEnabled < 3 {
                type = .bad
            } else if stringTypesEnabled >= 3 {
                type = .okay
            }
        } else if passwordLength > 10, passwordLength < 15 {
            if stringTypesEnabled == 0 {
                type = .none
            } else if stringTypesEnabled == 1 {
                type = .bad
            } else if stringTypesEnabled == 2 {
                type = .okay
            } else if stringTypesEnabled > 2 {
                type = .good
            }
        } else {
            if stringTypesEnabled == 0 {
                type = .none
            } else if stringTypesEnabled == 1 {
                type = .bad
            } else if stringTypesEnabled == 2 {
                type = .good
            } else if stringTypesEnabled >= 3 {
                type = .best
            }
        }
        return type
    }
    
    func passwordStrengthColor(for passwordStrength: PasswordStrength) -> UIColor {
        switch passwordStrength {
        case .none:
            return .black
        case .bad:
            return .red
        case .okay:
            return .orange
        case .good:
            return .yellow
        case .best:
            return .green
        }
    }
    
    func passwordStrengthColor() -> UIColor {
        let passwordStrength = self.passwordStrength()
        switch passwordStrength {
        case .none:
            return .black
        case .bad:
            return .red
        case .okay:
            return .orange
        case .good:
            return .yellow
        case .best:
            return .green
        }
    }
    
    func getPasswordStrengthColor(for text: String) -> UIColor {
        var stringTypes = 0
        var noLowerCaseChars: Bool = true
        var noUpperCaseChars: Bool = true
        var noSpecialChars: Bool = true
        var noNumbers: Bool = true
        for character in text {
            if noLowerCaseChars && self.lowerCaseLetters.contains(character) {
                noLowerCaseChars = false
                stringTypes += 1
                continue
            }
            if noUpperCaseChars && self.upperCaseLetters.contains(character) {
                noUpperCaseChars = false
                stringTypes += 1
                continue
            }
            if noSpecialChars && self.allSpecialChars.contains(character) {
                noSpecialChars = false
                stringTypes += 1
                continue
            }
            if noNumbers && self.allNumbers.contains(character) {
                noNumbers = false
                stringTypes += 1
                continue
            }
        }
        let passwordStrength = self.passwordStrength(stringTypes: stringTypes, passwordLength: text.count)
        return self.passwordStrengthColor(for: passwordStrength)
    }
    
    /**
     1. Combine internal arrays of `AccountCredential`s using square brackets `{}` -> array of strings -> N time
     2. Convert array of strings into Data suing Convertor -> N time
     3. Encrypt data using encryptor -> N time
     4. Store data in CoreData (convertor to Binary Data if needed?) -> Constant time
     5. Dencrypt data using encryptor
     6. Convert Data into array of strings
     7. Deconstruct each string into an `AccountCredential`
     Create tests to ensure it works as intended
     */
    
    func fetchCredentials() -> [AccountCredential] {
        var credentials: [AccountCredential] = []
        guard let fetchedData = try? context.fetch(AccountCredential.fetchRequest()) else {
            return []
        }
        guard let encryptedData = fetchedData.last?.credentials else {
            return []
        }
        let decryptedData = Encryptor.standard.decrypt(data: encryptedData)
        guard let decryptedData else {
            return []
        }
        guard let accountData = self.converter.dataToStringArray(decryptedData) else {
            return []
        }
        for accountDatum in accountData {
            credentials.append(self.converter.stringToCredential(accountDatum))
        }
        return credentials
    }
    
    func storeCredentials(_ credentials: [AccountCredential]) -> Bool {
        self.deleteStore()
        let sortedCredentials = self.sortCredentials(credentials)
        
        var accountArray: [String] = []
        for credential in sortedCredentials {
            accountArray.append(self.converter.credentialToString(credential))
        }
        guard let accountData = self.converter.stringArrayToData(accountArray),
              let encryptedData = Encryptor.standard.encrypt(data: accountData) else {
            return false
        }
        guard let encryptedCredentials = NSEntityDescription.insertNewObject(forEntityName: "EncryptedCredentials", into: context) as? EncryptedCredentials else {
            return false
        }
        encryptedCredentials.credentials = encryptedData
        do {
            try context.save()
            print("Credentials were saved")
            return true
        } catch {
            print("Credentials could not save")
            return false
        }
    }
    
    func deleteAllData() {
        self.deletePasswordData()
        self.deleteStore()
        try? context.save()
    }
    
    private func deletePasswordData() {
        self.userDefaults?.removeObject(forKey: self.specialCharKey)
        self.userDefaults?.removeObject(forKey: self.numbersKey)
        self.userDefaults?.removeObject(forKey: self.upperCaseKey)
        self.userDefaults?.removeObject(forKey: self.lowerCaseKey)
        self.userDefaults?.removeObject(forKey: self.passwordLengthKey)
    }
    
    private func deleteStore() {
        guard let data = try? context.fetch(AccountCredential.fetchRequest()) else {
            return
        }
        for object in data {
            context.delete(object)
        }
    }
    
    private func sortCredentials(_ credentials: [AccountCredential]) -> [AccountCredential] {
        return credentials.sorted(by: { $0.title.lowercased() < $1.title.lowercased() })
    }
}

