//
//  UserEndpoint.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Alamofire
import Marshal

struct UserEndpoint: APIEndpoint {

    var path: String {
        return "/user"
    }
    
    typealias ResponseType = UserProfile
    
    var method: HTTPMethod { return .get }
    var encoding: ParameterEncoding { return JSONEncoding.default }
    var parameters: JSONObject?
    var headers: HTTPHeaders { return [:] }

}

struct UserProfile {
    var user: User?
}

extension UserProfile: Unmarshaling {
    init(object json: MarshaledObject) throws {
        if let user = json as? [AnyHashable : Any] {
            self.user = User(dictionary: user)
        }
    }
}
