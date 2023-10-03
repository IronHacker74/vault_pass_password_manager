//
//  UnlockMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

protocol UnlockDelegate {
    func unlockViewDidAppear()
    func unlockWithAppleAuth()
    func termsAndConditionsButtonAction()
}
class UnlockMediatingController: UIViewController, UIViewLoading {
    
    @IBOutlet private(set) var unlockButton: UIButton!
    @IBOutlet private(set) var termsAndConditionsBtn: UIButton!
    @IBOutlet private(set) var privacyPolicyBtn: UIButton!
    @IBOutlet private(set) var padConstraints: [NSLayoutConstraint]! {
        didSet {
            PadConstraints.setLeadingTrailingConstraints(self.padConstraints)
        }
    }
    
    var delegate: UnlockDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = UnlockCoordinator(factory: UnlockFactory(), navigation: self.navigationController)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.delegate?.unlockViewDidAppear()
    }
    
    @IBAction func unlockButtonPressed(_ sender: UIButton) {
        self.delegate?.unlockWithAppleAuth()
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        OpenAppLink.using(.termsAndConditions, vc: self)
    }
    
    @IBAction func privacyPolicyButtonPressed(_ sender: UIButton) {
        OpenAppLink.using(.privacyPolicy, vc: self)
    }
}
