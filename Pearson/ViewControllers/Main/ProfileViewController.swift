//
//  ProfileViewController.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

class ProfileViewController: BaseViewController {

    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    
    override func configureUI() {
        userNameLabel.text = User.current().fullName
        userEmailLabel.text = User.current().email
    }

    @IBAction func logoutTapped(_ sender: UIButton) {
        _ = APIClient.shared.logout { _ in
            self.router()?.showAuth()
        }
    }
}
