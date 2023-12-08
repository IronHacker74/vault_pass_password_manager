//
//  ManagePaymentMediatingController.swift
//  VaultPass
//
//  Created by Andrew Masters on 12/5/23.
//

import UIKit

protocol ManagePaymentDelegate {
    func managePaymentMediatingControllerDidTouchContinue(paymentType: PaymentType)
    func managePaymentMediatingControllerDidTouchCancel()
    func managePaymentMediatingControllerDidTouchDone()
}

enum PaymentType {
    case monthlySubscription
    case oneTimePurchase
}

final class ManagePaymentMediatingController: UIViewController {
    @IBOutlet private (set) var continueButton: UIButton!
    @IBOutlet private (set) var cancelButton: UIButton!
    @IBOutlet private (set) var monthlySubscriptionView: UIView!
    @IBOutlet private (set) var monthlySubscriptionButton: UIButton!
    @IBOutlet private (set) var oneTimePurchaseView: UIView!
    @IBOutlet private (set) var oneTimePurchaseButton: UIButton!
    
    private let delegate: ManagePaymentDelegate?
    private var selectedPaymentType: PaymentType
    private let circleImage = UIImage(systemName: "circle")
    private let checkmarkImage = UIImage(systemName: "checkmark.circle.fill")
    
    init(delegate: ManagePaymentDelegate?) {
        self.delegate = delegate
        self.selectedPaymentType = .oneTimePurchase
        super.init(nibName: "ManagePaymentMediatingController", bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // TODO: Do not let the user get to screen if purchased
        self.navigationItem.hidesBackButton = true
        self.didTapMonthlySubscription()
        self.addMonthlySubscriptionTapGesture()
        self.addOneTimePurchaseTapGesture()
    }
    
    private func addMonthlySubscriptionTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapMonthlySubscription))
        self.monthlySubscriptionView.addGestureRecognizer(tapGesture)
    }
    
    private func addOneTimePurchaseTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapOneTimePurchase))
        self.oneTimePurchaseView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didTapMonthlySubscription() {
        guard self.selectedPaymentType == .oneTimePurchase else { return }
        self.selectedPaymentType = .monthlySubscription
        self.monthlySubscriptionButton.setImage(self.checkmarkImage, for: .normal)
        self.monthlySubscriptionView.selected()
        self.oneTimePurchaseButton.setImage(self.circleImage, for: .normal)
        self.oneTimePurchaseView.unselect()
    }
    
    @objc func didTapOneTimePurchase() {
        guard self.selectedPaymentType == .monthlySubscription else { return }
        self.selectedPaymentType = .oneTimePurchase
        self.oneTimePurchaseButton.setImage(self.checkmarkImage, for: .normal)
        self.oneTimePurchaseView.selected()
        self.monthlySubscriptionButton.setImage(self.circleImage, for: .normal)
        self.monthlySubscriptionView.unselect()
    }
    
    @IBAction func didTapMonthlySubscriptionBtn(_ sender: UIButton) {
        self.didTapMonthlySubscription()
    }
    
    @IBAction func didTapOneTimePurchaseBtn(_ sender: UIButton) {
        self.didTapOneTimePurchase()
    }
    
    @IBAction func didTouchContinue(_ sender: UIButton) {
        self.delegate?.managePaymentMediatingControllerDidTouchContinue(paymentType: self.selectedPaymentType)
    }
    
    @IBAction func didTouchCancel(_ sender: UIButton) {
        self.delegate?.managePaymentMediatingControllerDidTouchCancel()
    }
}
