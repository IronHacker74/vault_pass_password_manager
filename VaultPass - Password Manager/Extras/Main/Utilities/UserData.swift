//
//  UserData.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/17/23.
//

import Foundation

final class UserData {
    
    private let data = UserDefaults.standard
    
    private let firstTimeUserKey = "first_time_user_key"
    private let autoUnlock = "auto_unlock"
    private let alwaysShowCredentials = "always_show_credentials"
    private let autofillSettings = AutofillDataSettings()
    
    func getNotFirstUnlock() -> Bool {
        return self.data.bool(forKey: self.firstTimeUserKey)
    }
    
    func setNotFirstUnlock(_ value: Bool) {
        self.data.set(value, forKey: self.firstTimeUserKey)
    }
    
    func getAutoUnlock() -> Bool {
        return self.data.bool(forKey: self.autoUnlock)
    }
    
    func setAutoUnlock(_ value: Bool) {
        self.data.set(value, forKey: self.autoUnlock)
    }
    
    func getAlwaysShowCredentials() -> Bool {
        return self.data.bool(forKey: self.alwaysShowCredentials)
    }
    
    func setAlwaysShowCredentials(_ value: Bool) {
        self.data.set(value, forKey: self.alwaysShowCredentials)
    }
    
    func getAutoUpdateIdentifiers() -> Bool {
        return self.autofillSettings.getAutoUpdateIdentifiers()
    }
    
    func setAutoUpdateIdnetifiers(_ value: Bool) {
        self.autofillSettings.setAutoUpdateIdentifiers(value)
    }
    
    func deleteData() {
        self.data.removeObject(forKey: self.firstTimeUserKey)
        self.data.removeObject(forKey: self.autoUnlock)
        self.data.removeObject(forKey: self.alwaysShowCredentials)
        self.autofillSettings.deleteData()
    }
}
