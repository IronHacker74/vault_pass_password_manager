//
//  PaymentConfirmationMediatingController.swift
//  VaultPass
//
//  Created by Andrew Masters on 12/7/23.
//

import UIKit

final class PaymentConfirmationMediatingController: UIViewController {
    @IBOutlet private var doneButton: UIButton!
    
    private let delegate: ManagePaymentDelegate?
    
    init(delegate: ManagePaymentDelegate?) {
        self.delegate = delegate
        super.init(nibName: "PaymentConfirmationMediatingController", bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func didTouchDone(_ sender: UIButton) {
        self.delegate?.managePaymentMediatingControllerDidTouchDone()
    }
}
