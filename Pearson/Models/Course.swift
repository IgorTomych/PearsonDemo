//
//  Course.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Marshal

struct Course {
    
    let courseId: String
    
    let name: String?
    
    let subject: String?
    
    let thumbnailLink: String?
    
    func thumbnailURL() -> URL? {
        guard let urlString = thumbnailLink else {
            return nil
        }
        return URL(string: urlString)
    }
}

extension Course: Unmarshaling {
    init(object: MarshaledObject) throws {
        self.courseId = object.optionalAny(for: "id") as? String ?? ""
        self.name = object.optionalAny(for: "name") as? String ?? ""
        self.subject = object.optionalAny(for: "subject") as? String ?? ""
        self.thumbnailLink = object.optionalAny(for: "thumbnail") as? String ?? ""
    }
}
