//
//  CopyToClipboardConfirmationView.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/15/23.
//

import UIKit

protocol CopyToClipboardViewDelegate {
    func showCopyToClipboardView(message: String?)
}

extension CopyToClipboardViewDelegate {
    func showCopyToClipboardView(view: UIView, delegate: CopyToClipboardDelegate?, message: String?) -> CopyToClipboardConfirmationView {
        let copyToClipboardView = CopyToClipboardConfirmationView.loadFromNib()
        copyToClipboardView.setup(delegate: delegate, message: message)
        copyToClipboardView.translatesAutoresizingMaskIntoConstraints = false
        UIView.transition(with: view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
          view.addSubview(copyToClipboardView)
        }, completion: nil)
        NSLayoutConstraint.activate([
            copyToClipboardView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -25),
            copyToClipboardView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            copyToClipboardView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            copyToClipboardView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        return copyToClipboardView
    }
    
    func dismissCopyToClipboardView(_ view: UIView, _ clipboardView: CopyToClipboardConfirmationView?) {
        guard let clipboardView else { return }
        UIView.transition(with: view, duration: 0.25, options: [.transitionCrossDissolve], animations: {
            clipboardView.removeFromSuperview()
        }, completion: nil)
    }
    
    func replaceCopyToClipboardView(_ view: UIView, clipboardView: CopyToClipboardConfirmationView?, message: String?, delegate: CopyToClipboardDelegate?, completion: @escaping ((CopyToClipboardConfirmationView) -> Void)) {
        UIView.transition(with: view, duration: 0, options: [.transitionCrossDissolve], animations: {
            self.dismissCopyToClipboardView(view, clipboardView)
        }, completion: {_ in
            completion(showCopyToClipboardView(view: view, delegate: delegate, message: message))
        })
    }
}

protocol CopyToClipboardDelegate {
    func dismissClipboardView()
}

class CopyToClipboardConfirmationView: UIView, UIViewLoading {
    
    @IBOutlet private(set) var messageLabel: UILabel!
    
    var delegate: CopyToClipboardDelegate?
    
    func setup(delegate: CopyToClipboardDelegate?, message: String?) {
        self.delegate = delegate
        self.messageLabel.text = message
        self.layer.cornerRadius = 15
        self.layer.borderWidth = 1.5
        self.layer.borderColor = UIColor.vaultPassYellow()?.cgColor
    }
    
    @IBAction func dismissButtonPressed(_ sender: UIButton) {
        self.delegate?.dismissClipboardView()
    }
}
