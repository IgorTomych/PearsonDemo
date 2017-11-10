//
//  APIError.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Alamofire
import Marshal

enum APIError: Error {
    case tokenExpired
    case invalidCredentials
    case invalidResponse
    case server
}

func APIResponseValidator(request: URLRequest?, response: HTTPURLResponse, data: Data?) -> Request.ValidationResult {
    // Generate an error if the status code isn't acceptable. If no error is
    // returned here, the request will not be retried.
    switch response.statusCode {
    case 401:
        return .failure(APIError.invalidCredentials)
    case 400..<500:
        return .failure(APIError.invalidResponse)
    case 500..<Int.max:
        return .failure(APIError.server)
    default:
        break
    }
    return .success
}
