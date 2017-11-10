//
//  SchoolLinks.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Foundation

class SchoolLinks: NSObject {
    var serviceLink: String
    
    convenience override init() {
        self.init(dictionary: [:])
    }
    
    init(dictionary: [AnyHashable : Any]) {
        self.serviceLink = dictionary["services"] as? String ?? ""
    }
    
}
