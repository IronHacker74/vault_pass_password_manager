//
//  CustomAlert.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/30/23.
//

import UIKit

struct CustomAlert {
        
    static func destructive(_ controller: UIViewController, title: String, message: String, style: UIAlertController.Style, deleteBtn: String, deleteAction: @escaping ((UIAlertAction) -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel){ _ in
            alertController.dismiss(animated: true)
        })
        alertController.addAction(UIAlertAction(title: deleteBtn, style: .destructive, handler: deleteAction))
        controller.present(alertController, animated: true)
    }
    
    static func ok(_ controller: UIViewController, title: String, message: String, style: UIAlertController.Style) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel){ _ in
            alertController.dismiss(animated: true)
        })
        controller.present(alertController, animated: true)
    }
}
