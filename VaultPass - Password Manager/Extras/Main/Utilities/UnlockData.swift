//
//  UnlockData.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/17/23.
//

import Foundation

class UnlockData {
    
    private let data = UserDefaults.standard
    
    private let firstTimeUserKey = "first_time_user_key"
    private let autoUnlock = "auto_unlock"
    
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
    
    func deleteData() {
        self.data.removeObject(forKey: self.firstTimeUserKey)
        self.data.removeObject(forKey: self.autoUnlock)
    }
}
