//
//  School.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Foundation

class School: NSObject {
    
    fileprivate static var currentSchool = School()
    
    class func current() -> School {
        return currentSchool
    }
    
    class func setCurrentSchool(school: School) {
        currentSchool = school
    }
    
    let schoolId: String
    
    let name: String?
    
    let links: SchoolLinks?
    
    convenience override init() {
        self.init(dictionary: [:])
    }
    
    init(dictionary: [AnyHashable : Any]) {
        self.schoolId = dictionary["id"] as? String ?? ""
        self.name = dictionary["name"] as? String ?? ""
        
        if let linksDictionary = dictionary["links"] as? [AnyHashable : Any] {
           self.links = SchoolLinks(dictionary: linksDictionary)
        } else {
            self.links = nil
        }
    }
    
}
