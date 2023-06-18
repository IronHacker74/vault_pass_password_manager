//
//  UIView+.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/15/23.
//

import UIKit

extension UIView {
    class func initFromNib<T: UIView>() -> T {
        return Bundle(for: T.self).loadNibNamed(String(describing: T.self), owner: nil, options: nil)![0] as! T
    }
}
