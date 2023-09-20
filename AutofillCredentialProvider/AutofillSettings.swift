//
//  AutofillSettings.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 9/11/23.
//

import Foundation

final class AutofillDataSettings {
    
    private let data = UserDefaults(suiteName: "group.vaultpass.masters")
    private let autoUpdateIdentifiers = "auto_update_identifiers"
    
    func getAutoUpdateIdentifiers() -> Bool {
        return self.data?.bool(forKey: self.autoUpdateIdentifiers) ?? false
    }
    
    func setAutoUpdateIdentifiers(_ value: Bool) {
        self.data?.set(value, forKey: self.autoUpdateIdentifiers)
    }
    
    func deleteData() {
        self.data?.removeObject(forKey: self.autoUpdateIdentifiers)
    }
}
