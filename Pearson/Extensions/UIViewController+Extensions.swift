//
//  UIViewController+Extensions.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

extension UIViewController {
    func router() -> RoutableWindow? {
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            return appDelegate.window as? RoutableWindow
        }
        
        return nil
    }
}

