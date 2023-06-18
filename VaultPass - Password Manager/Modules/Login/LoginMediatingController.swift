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
}
class LoginMediatingController: UIViewController {
    
    @IBOutlet private(set) var loginButton: UIButton!
    @IBOutlet private(set) var loginDetailLabel: UILabel!
    
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
}
