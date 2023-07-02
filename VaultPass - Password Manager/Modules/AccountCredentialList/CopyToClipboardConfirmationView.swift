//
//  CopyToClipboardConfirmationView.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/15/23.
//

import UIKit

protocol CopyToClipboardViewDelegate {
    func showCopyToClipboardView()
}

extension CopyToClipboardViewDelegate {
    func showCopyToClipboardView(view: UIView, delegate: CopyToClipboardDelegate?) -> CopyToClipboardConfirmationView {
        let copyToClipboardView = CopyToClipboardConfirmationView.loadFromNib()
        copyToClipboardView.setup(delegate: delegate)
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
    
    func replaceCopyToClipboardView(_ view: UIView, clipboardView: CopyToClipboardConfirmationView?, delegate: CopyToClipboardDelegate?, completion: @escaping ((CopyToClipboardConfirmationView) -> Void)) {
        UIView.transition(with: view, duration: 0, options: [.transitionCrossDissolve], animations: {
            self.dismissCopyToClipboardView(view, clipboardView)
        }, completion: {_ in
            completion(showCopyToClipboardView(view: view, delegate: delegate))
        })
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
