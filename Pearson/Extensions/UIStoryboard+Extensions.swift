//
//  UIStoryboard+Extensions.swift
//  Pearson
//
//  Created by Denys Trush on 10.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import UIKit

extension UIStoryboard {
    static func main() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }
    
    static func auth() -> UIStoryboard {
        return UIStoryboard(name: "Auth", bundle: nil)
    }
}
