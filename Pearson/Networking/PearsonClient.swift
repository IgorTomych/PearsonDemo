//
//  PearsonClient.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Alamofire
import Marshal

final class PearsonClient {
    
    static let credentials = "credentials"
    
    var credentials: Credentials? {
        didSet {
            if let credentials = credentials {
                UserDefaults.standard.set(credentials.accessToken, forKey: PearsonClient.credentials)
            } else {
                UserDefaults.standard.removeObject(forKey: PearsonClient.credentials)
            }
        }
    }
    
    var isAuthenticated: Bool {
        return credentials != nil
    }
    
    let baseURL: URL
    let manager: Alamofire.SessionManager
    init(baseURL: URL = APIProperties.authBaseURL, configuration: URLSessionConfiguration = .default) {
        self.baseURL = baseURL
        
        configuration.httpAdditionalHeaders?[APIConstants.accept] = APIConstants.applicationJSON
        self.manager = SessionManager(configuration: configuration)
        
        if let accessToken: String = UserDefaults.standard.object(forKey: PearsonClient.credentials) as? String {
            self.credentials = Credentials(accessToken: accessToken)
        }
    }
}

// MARK: Request Authorization

/// The PearsonClient is a request adapter for the APIClient
extension PearsonClient: RequestAdapter {
    
    func adapt(_ urlRequest: URLRequest) throws -> URLRequest {
        var urlRequest = urlRequest
        if let token = credentials?.accessToken {
            urlRequest.allHTTPHeaderFields?[APIConstants.authorization] = "Bearer \(token)"
        }
        urlRequest.allHTTPHeaderFields?[APIConstants.appVersion] = "1.0"
        urlRequest.allHTTPHeaderFields?[APIConstants.acceptLanguage] = "en"
        urlRequest.allHTTPHeaderFields?[APIConstants.deviceID] = APIProperties.deviceIDValue
        return urlRequest
    }
}
