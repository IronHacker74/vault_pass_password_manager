//
//  IdentifierTextFieldCell.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 9/10/23.
//

import UIKit

protocol IdentifierTextFieldCellDelegate {
    func identifierTextFieldDidBeginEditing(origin: CGPoint)
    func textFieldCellDidUpdate(text: String, index: Int)
    func identifierTextFieldDidEndEditing()
    func deleteIdentifier(_ index: Int)
}

final class IdentifierTextFieldCell: UITableViewCell, UITextFieldDelegate, UIViewLoading {
    @IBOutlet weak var identifierTextField: UITextField!
    @IBOutlet weak var deleteButton: UIButton!
    
    private var delegate: IdentifierTextFieldCellDelegate?
    private var index: Int?
    
    func configureIdentifier(delegate: IdentifierTextFieldCellDelegate, identifier: String, index: Int) {
        self.delegate = delegate
        self.identifierTextField.text = identifier
        self.index = index
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.identifierTextFieldDidBeginEditing(origin: self.frame.origin)
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        guard let index = self.index else { return }
        self.delegate?.deleteIdentifier(index)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.delegate?.identifierTextFieldDidEndEditing()
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let index = self.index else { return true }
        guard let text = textField.text else { return true }
        let fullText = text + string
        self.delegate?.textFieldCellDidUpdate(text: fullText, index: index)
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
