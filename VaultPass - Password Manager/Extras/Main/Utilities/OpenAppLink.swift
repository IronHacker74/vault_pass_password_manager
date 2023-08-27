//
//  OpenAppLink.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 7/27/23.
//

import UIKit

enum AppLinks: String {
    case termsAndConditions = "https://sites.google.com/view/vaultpassapp/terms-and-conditions"
    case privacyPolicy = "https://sites.google.com/view/vaultpassapp/privacy-policy"
}

class OpenAppLink {
    
    static func using(_ applink: AppLinks, vc: UIViewController) {
        guard let url = URL(string: applink.rawValue) else {
            return
        }
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            CustomAlert.ok(vc, title: "Failed to open", message: "We cannot open that link right now.")
        }
    }
}
