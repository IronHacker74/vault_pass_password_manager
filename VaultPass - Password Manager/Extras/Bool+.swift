//
//  Bool+.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 8/19/23.
//

extension Bool {
    func toggle() -> Self {
        if self {
            return false
        }
        return true
    }
}
