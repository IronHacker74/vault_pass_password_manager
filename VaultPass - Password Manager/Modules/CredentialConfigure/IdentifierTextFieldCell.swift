//
//  IdentifierTextFieldCell.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 9/10/23.
//

import UIKit

protocol IdentifierTextFieldCellDelegate {
    func textFieldCellDidUpdate(text: String, index: Int)
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
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        guard let index = self.index else { return }
        self.delegate?.deleteIdentifier(index)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let index = self.index else { return }
        guard let text = textField.text else { return }
        self.delegate?.textFieldCellDidUpdate(text: text, index: index)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
}
