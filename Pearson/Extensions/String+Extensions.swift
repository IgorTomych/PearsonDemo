//
//  String+Extensions.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Foundation

extension String {
    func isValidEmail() -> Bool {
        let stricterFilterString = "[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
        let emailTest = NSPredicate(format:"SELF MATCHES %@", stricterFilterString)
        return emailTest.evaluate(with: self)
    }
}
