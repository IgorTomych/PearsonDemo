//
//  CoursesEndpoint.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Alamofire
import Marshal

struct CoursesEndpoint: APIEndpoint {
    
    let schoolId: String
    
    var path: String {
        return "/coursesection"
    }
    
    typealias ResponseType = [Course]
    
    var method: HTTPMethod { return .get }
    var encoding: ParameterEncoding { return URLEncoding.default }
    var parameters: JSONObject? { return ["schoolId": schoolId] }
    var headers: HTTPHeaders { return [:] }
    
}
