//
//  AccountCredentialsManager.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/7/23.
//

import UIKit
import CoreData

class AccountCredentialsManager {
    let converter: Converter = Converter()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    init() {
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
        var accountArray: [String] = []
        for credential in credentials {
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
    
    private func deleteStore() {
        guard let data = try? context.fetch(AccountCredential.fetchRequest()) else {
            return
        }
        for object in data {
            context.delete(object)
        }
    }
}

extension AccountCredential {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<EncryptedCredentials> {
        return NSFetchRequest<EncryptedCredentials>(entityName: "EncryptedCredentials")
    }
    @NSManaged public var credentials: Data?
}
