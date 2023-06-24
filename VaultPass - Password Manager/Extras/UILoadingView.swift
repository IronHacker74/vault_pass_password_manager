//
//  UILoadingView.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/19/23.
//

import UIKit

protocol UIViewLoading {}

extension UIViewLoading where Self : UIView {
    
    /**
     Creates a new instance of the class on which this method is invoked,
     instantiated from a nib of the given name. If no nib name is given
     then a nib with the name of the class is used.
     
     - parameter nibNameOrNil: The name of the nib to instantiate from, or
     nil to indicate the nib with the name of the class should be used.
     
     - returns: A new instance of the class, loaded from a nib.
     */
    static func loadFromNib(nibNameOrNil: String? = nil) -> Self {
        let nibName = nibNameOrNil ?? self.className
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiate(withOwner: self, options: nil).first as! Self
    }
    
    static private var className: String {
        let className = "\(self)"
        let components = className.split{$0 == "."}.map ( String.init )
        return components.last!
    }
}
