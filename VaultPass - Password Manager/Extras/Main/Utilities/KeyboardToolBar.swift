//
//  TextFieldBar.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 9/3/23.
//

import UIKit

final class KeyboardToolBar: UIToolbar {
    private let textFieldTag: Int
    private let view: UIView
    
    init(view: UIView, textFieldTag: Int) {
        self.view = view
        self.textFieldTag = textFieldTag
        super.init(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let fixedSpaceItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpaceItem.width = 10
        self.items = [
            UIBarButtonItem(image: UIImage(systemName: "chevron.up"), style: .plain, target: self, action: #selector(upButtonTapped)),
            fixedSpaceItem,
            UIBarButtonItem(image: UIImage(systemName: "chevron.down"), style: .plain, target: self, action: #selector(downButtonTapped)),
            UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil),
            UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonTapped))
        ]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func upButtonTapped() {
        guard let currentTextField = self.view.viewWithTag(self.textFieldTag) else {
            return
        }
        let newTag = self.textFieldTag - 1
        guard newTag > 0 else {
            currentTextField.resignFirstResponder()
            return
        }
        if let nextTextField = self.view.viewWithTag(newTag) {
            nextTextField.becomeFirstResponder()
        } else {
            currentTextField.resignFirstResponder()
        }
    }
    
    @objc func downButtonTapped() {
        guard let currentTextField = self.view.viewWithTag(self.textFieldTag) else {
            return
        }
        let newTag = self.textFieldTag + 1
        if let nextTextField = self.view.viewWithTag(newTag) {
            nextTextField.becomeFirstResponder()
        } else {
            currentTextField.resignFirstResponder()
        }
    }
    
    @objc func doneButtonTapped() {
        guard let currentTextField = self.view.viewWithTag(self.textFieldTag) else {
            return
        }
        currentTextField.resignFirstResponder()
    }
}
