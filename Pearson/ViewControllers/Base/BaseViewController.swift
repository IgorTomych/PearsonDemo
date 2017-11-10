//
//  BaseViewController.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit
import SVProgressHUD

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {}
    
    func showHUD() {
        SVProgressHUD.show()
    }
    
    func hideHUD() {
        SVProgressHUD.dismiss()
    }
    
    func handleError(error: Error) {
        if let apiError = error as? APIError, apiError == .invalidCredentials {
            self.router()?.showAuth()
            return
        }
        
        let alert = UIAlertController.cancelableAlertWithOKButton(title: nil, message: "Error occured")
        self.present(alert, animated: true, completion: nil)
    }
}
