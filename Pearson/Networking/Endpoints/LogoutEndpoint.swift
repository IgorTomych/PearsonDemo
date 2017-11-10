//
//  LogoutEndpoint.swift
//  Pearson
//
//  Created by Kirill Ushkov on 11.11.17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Alamofire
import Marshal

struct LogoutEndpoint: APIEndpoint {
    var path: String {
        return "/user/logout"
    }
    
    typealias ResponseType = LogoutResponse
    
    var method: HTTPMethod { return .get }
    var encoding: ParameterEncoding { return URLEncoding.default }
    var parameters: JSONObject? { return [:] }
    var headers: HTTPHeaders { return [:] }
}

struct LogoutResponse: Unmarshaling {
    init(object: MarshaledObject) throws {
        print(object)
    }
}


