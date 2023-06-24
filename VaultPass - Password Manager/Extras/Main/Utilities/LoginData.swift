//
//  LoginData.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/17/23.
//

import Foundation

class LoginData {
    
    private let data = UserDefaults.standard
    
    private let firstTimeUserKey = "first_time_user_key"
    
    func getNotFirstLogin() -> Bool {
        return self.data.bool(forKey: self.firstTimeUserKey)
    }
    
    func setNotFirstLogin(_ value: Bool) {
        self.data.set(value, forKey: self.firstTimeUserKey)
    }
    
    func deleteData() {
        self.data.removeObject(forKey: self.firstTimeUserKey)
    }
}
