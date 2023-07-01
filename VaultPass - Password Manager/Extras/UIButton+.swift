//
//  UIButton+.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/27/23.
//

import UIKit

extension UIButton {
    func showCredential(title: String? = "") {
        self.isUserInteractionEnabled = true
        self.setTitle(title, for: .normal)
        self.setTitleColor(.systemBlue, for: .normal)
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    func hideCredential(placeHolder: String) {
        self.isUserInteractionEnabled = false
        self.setTitle(placeHolder, for: .normal)
        self.setTitleColor(.opaqueSeparator, for: .normal)
        self.layer.borderColor = UIColor.opaqueSeparator.cgColor
    }
}
