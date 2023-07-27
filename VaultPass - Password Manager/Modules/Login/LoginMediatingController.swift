//
//  LoginMediatingController.swift
//  VaultPass - Password Manager
//
//  Created by Andrew Masters on 6/6/23.
//

import UIKit

protocol LoginDelegate {
    func loginViewDidAppear()
    func loginWithAppleAuth()
    func termsAndConditionsButtonAction()
}
class LoginMediatingController: UIViewController, UIViewLoading {
    
    @IBOutlet private(set) var loginButton: UIButton!
    @IBOutlet private(set) var loginDetailLabel: UILabel!
    @IBOutlet private(set) var termsAndConditionsBtn: UIButton!
    @IBOutlet private(set) var privacyPolicyBtn: UIButton!
    
    var delegate: LoginDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = LoginCoordinator(factory: LoginFactory(), navigation: self.navigationController)
        self.loginDetailLabel.text = "Use your iPhone's authentication to login and manage your passwords."
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.delegate?.loginViewDidAppear()
    }
    
    @IBAction func loginButtonPressed(_ sender: UIButton) {
        self.delegate?.loginWithAppleAuth()
    }
    
    @IBAction func termsAndConditionsButtonPressed(_ sender: UIButton) {
        OpenAppLink.using(.termsAndConditions, vc: self)
    }
    
    @IBAction func privacyPolicyButtonPressed(_ sender: UIButton) {
        OpenAppLink.using(.privacyPolicy, vc: self)
    }
}
