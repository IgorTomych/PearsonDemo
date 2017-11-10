//
//  UIAlertController+Extensions.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

extension UIAlertController {
    class func pendingAlert() -> UIAlertController {
        return UIAlertController.cancelableAlertWithOKButton(title: nil, message: "Pending")
    }
    
    class func cancelableAlertWithOKButton(title: String?, message: String?) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alertController.addAction(OKAction)
        
        return alertController
    }
}
