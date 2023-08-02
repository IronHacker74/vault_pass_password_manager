//
//  BiometricUnlock.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 7/18/23.
//

import LocalAuthentication

public final class BiometricUnlock {
    public static func unlockWithAppleAuth(completion: @escaping (Bool,Error?) -> (Void)) {
        let context = LAContext()
        var error: NSError?
        guard context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) else {
            print(error?.localizedDescription ?? "Can't evaluate policy")
            return
        }
        Task {
            do {
                try await context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Unlock to manager your passwords")
                print("Succcessful authentication")
                DispatchQueue.main.async {
                    completion(true, nil)
                }
            } catch let error {
                completion(false, error)
                print(error.localizedDescription)
            }
        }
    }
}
