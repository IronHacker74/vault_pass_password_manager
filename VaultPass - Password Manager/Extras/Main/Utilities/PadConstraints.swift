//
//  PadConstraints.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 8/25/23.
//

import UIKit

final class PadConstraints {
    static let padConstant: CGFloat = 96
    
    static func setLeadingTrailingConstraints(_ constraints: [NSLayoutConstraint]){
        if UIDevice.current.userInterfaceIdiom == .pad {
            for constraint in constraints {
                if constraint.constant <= 0 && constraint.constant != (self.padConstant * -1) {
                    constraint.constant = self.padConstant * -1
                } else if constraint.constant != self.padConstant {
                    constraint.constant = self.padConstant
                }
            }
        }
    }
}
