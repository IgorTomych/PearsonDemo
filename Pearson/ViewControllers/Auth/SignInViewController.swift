//
//  SignInViewController.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

class SignInViewController: EnterUsernameViewController {
    
    var userEmail: String!
    @IBOutlet weak var passwordField: UITextField!
    
    override func configureUI() {
        super.configureUI()

        let imageView = UIImageView(image: UIImage(named:"userBlueIcon"))
        emailField.leftView = imageView
        emailField.leftViewMode = .always
        emailField.text = userEmail
        
        passwordField.leftView = UIImageView(image: UIImage(named:"passwordIcon"))
        passwordField.leftViewMode = .always
        
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "eyeIcon"), for: .normal)
        button.addTarget(self, action: #selector(self.togglePasswordVisibility(sender:)), for: .touchUpInside)
        button.sizeToFit()
        passwordField.rightView = button
        passwordField.rightViewMode = .always
    }
    
    @objc func togglePasswordVisibility(sender: UIButton) {
        passwordField.isSecureTextEntry = !passwordField.isSecureTextEntry
    }
    
    override func performAction() {
        guard let pass = passwordField.text else {
            return
        }
        showHUD()
        _ = APIClient.shared.login(userName: userEmail, password: pass) { error in
            self.hideHUD()
            if let er = error {
                self.handleError(error: er)
            } else {
                self.router()?.showMain()
            }
        }
    }
    
    override func validateInput() -> Bool {
        guard let password = passwordField.text else {
            return false
        }
        return password.count != 0
    }
}
