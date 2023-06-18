//
//  CopyToClipboardConfirmationView.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/15/23.
//

import UIKit

protocol CopyToClipboardView {
    func showCopyToClipboardView()
}

extension CopyToClipboardView {
    func showCopyToClipboardView(view: UIView, delegate: CopyToClipboardDelegate?) -> CopyToClipboardConfirmationView {
        let copyToClipboardView = (Bundle.main.loadNibNamed("CopyToClipboardConfirmationView", owner: nil)![0]) as! CopyToClipboardConfirmationView
        copyToClipboardView.delegate = delegate
        copyToClipboardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(copyToClipboardView)
        
        NSLayoutConstraint.activate([
            copyToClipboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
//            copyToClipboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
//            copyToClipboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 20),
            copyToClipboardView.heightAnchor.constraint(equalToConstant: 50)
        ])
        return copyToClipboardView
    }
}

protocol CopyToClipboardDelegate {
    func dismissClipboardView()
}

class CopyToClipboardConfirmationView: UIView {
    
    var delegate: CopyToClipboardDelegate?
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.delegate?.dismissClipboardView()
    }
}
