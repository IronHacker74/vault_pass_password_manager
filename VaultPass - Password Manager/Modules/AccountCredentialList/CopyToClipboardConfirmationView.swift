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
        let copyToClipboardView = CopyToClipboardConfirmationView.loadFromNib()
        copyToClipboardView.setup(delegate: delegate)
        copyToClipboardView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(copyToClipboardView)
        NSLayoutConstraint.activate([
            copyToClipboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -50),
            copyToClipboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            copyToClipboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            copyToClipboardView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return copyToClipboardView
    }
}

protocol CopyToClipboardDelegate {
    func dismissClipboardView()
}

class CopyToClipboardConfirmationView: UIView, UIViewLoading {
    
    var delegate: CopyToClipboardDelegate?
    
    func setup(delegate: CopyToClipboardDelegate?) {
        self.delegate = delegate
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.systemBlue.cgColor
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.delegate?.dismissClipboardView()
    }
}
