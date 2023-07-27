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
    private let autoLogin = "auto_login"
    
    func getNotFirstLogin() -> Bool {
        return self.data.bool(forKey: self.firstTimeUserKey)
    }
    
    func setNotFirstLogin(_ value: Bool) {
        self.data.set(value, forKey: self.firstTimeUserKey)
    }
    
    func getAutoLogin() -> Bool {
        return self.data.bool(forKey: self.autoLogin)
    }
    
    func setAutoLogin(_ value: Bool) {
        self.data.set(value, forKey: self.autoLogin)
    }
    
    func deleteData() {
        self.data.removeObject(forKey: self.firstTimeUserKey)
        self.data.removeObject(forKey: self.autoLogin)
    }
}
