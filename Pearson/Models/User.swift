//
//  User.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Foundation

class User: NSObject {

    class func isAuthorized() -> Bool {
        return APIClient.shared.pearsonClient.isAuthenticated
    }
    
    fileprivate static var currentUser = User()
    
    class func current() -> User {
        return currentUser
    }
    
    class func setCurrentUser(user: User) {
        currentUser = user
    }

    let userId: String
    
    let email: String?
    
    let firstName: String?
    
    let lastName: String?
    
    let fullName: String?
    
    let schools: [School]?
    
    convenience override init() {
        self.init(dictionary: [:])
    }
    
    init(dictionary: [AnyHashable : Any]) {
        self.userId = dictionary["id"] as? String ?? ""
        self.firstName = dictionary["fName"] as? String
        self.lastName = dictionary["lName"] as? String
        self.email = dictionary["email"] as? String
        self.fullName = dictionary["name"] as? String
        self.schools = Array()
        if let schoolsArray = dictionary["schools"] as? [[AnyHashable : Any]] {
            for schoolDictionary in schoolsArray {
                let school = School(dictionary: schoolDictionary)
                self.schools?.append(school)
            }
        }
    }
    
    func getMainSchool() -> School? {
        return schools?.first
    }
    
}
