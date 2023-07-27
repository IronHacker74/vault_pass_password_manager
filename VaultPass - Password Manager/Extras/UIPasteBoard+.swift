//
//  UIPasteBoard+.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 7/25/23.
//

import UIKit

extension UIPasteboard {
    static func copyToClipboard(_ value: String) {
        self.general.string = value
    }
}
