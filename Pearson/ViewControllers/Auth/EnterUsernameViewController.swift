//
//  EnterUsernameViewController.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class EnterUsernameViewController: BaseViewController, UITextFieldDelegate {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var actionButton: UIButton!
    
    override func configureUI() {
        let layer = actionButton.layer
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.withAlphaComponent(0.5).cgColor
        layer.shadowOffset = CGSize(width: -2, height: 2)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.8
        
        let imageView = UIImageView(image: UIImage(named:"userIcon"))
        emailField.leftView = imageView
        emailField.leftViewMode = .always
    }
    
    @IBAction func termsAndConditionsTapped(_ sender: UIButton) {
        let pendingAlert = UIAlertController.pendingAlert()
        present(pendingAlert, animated: true, completion: nil)
    }
    
    @IBAction func actionButtonTapped(_ sender: UIButton) {
        if validateInput() == true {
            performAction()
            return
        }

        let alert = UIAlertController.cancelableAlertWithOKButton(title: nil, message: "Please enter correct data")
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func unwindToMainMenu(sender: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let signIn = segue.destination as? SignInViewController, let email = emailField.text {
            signIn.userEmail = email
        }
    }
    
    func performAction() {
        performSegue(withIdentifier: "showSignIn", sender: nil)
    }
    
    func validateInput() -> Bool {
        if let email = emailField.text {
            return email.count > 0
        }
        
        return false
    }

    
    // MARK: UITextFieldDelegate
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.returnKeyType == .done {
            textField.resignFirstResponder()
        }
        return true
    }

}
