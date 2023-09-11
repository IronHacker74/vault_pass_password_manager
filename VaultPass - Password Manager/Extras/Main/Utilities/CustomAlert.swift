//
//  CustomAlert.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/30/23.
//

import UIKit

struct CustomAlert {  
    static func destructive(_ controller: UIViewController, title: String, message: String, deleteBtn: String, deleteAction: @escaping ((UIAlertAction) -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel){ _ in
            alertController.dismiss(animated: true)
        })
        alertController.addAction(UIAlertAction(title: deleteBtn, style: .destructive, handler: deleteAction))
        controller.present(alertController, animated: true)
    }
    
    static func ok(_ controller: UIViewController, title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel){ _ in
            alertController.dismiss(animated: true)
        })
        controller.present(alertController, animated: true)
    }
    
    static func decision(_ controller: UIViewController, title: String, message: String, yesAction: @escaping ((UIAlertAction) -> Void), cancelAction: @escaping ((UIAlertAction) -> Void)) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: cancelAction))
        alertController.addAction(UIAlertAction(title: "Yes", style: .default, handler: yesAction))
        controller.present(alertController, animated: true)
    }
}
