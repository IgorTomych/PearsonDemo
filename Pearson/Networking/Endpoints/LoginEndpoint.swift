//
//  LoginEndpoint.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Alamofire
import Marshal

struct LoginEndpoint: APIEndpoint {
    
    let userName: String
    let password: String
    
    var path: String {
        return "/user/authenticate"
    }
    
    typealias ResponseType = Credentials
    
    var method: HTTPMethod { return .post }
    var encoding: ParameterEncoding { return JSONEncoding.default }
    var parameters: JSONObject? {
        let parameters = ["username": userName, "password": password]
        return parameters
    }
    var headers: HTTPHeaders { return [:] }
    
}

struct Credentials {
    var accessToken: String?
}

extension Credentials: Unmarshaling {
    init(object json: MarshaledObject) throws {
        if let credentials = json.optionalAny(for: APIConstants.accessToken) as? String {
            self.accessToken = credentials
        }
    }
}
