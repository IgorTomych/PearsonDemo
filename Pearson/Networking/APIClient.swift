//
//  APIClient.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Alamofire
import Marshal

final class APIClient {
    static var shared = APIClient()
    
    let authManager: Alamofire.SessionManager
    var courseManager: Alamofire.SessionManager!
    
    let pearsonClient: PearsonClient
    let baseAuthURL: URL
    var baseCourseURL: URL!
    let authorizationToken: String? = nil
    
    init(baseAuthURL: URL = APIProperties.authBaseURL, configuration: URLSessionConfiguration = .default) {
        self.baseAuthURL = baseAuthURL
        self.pearsonClient = PearsonClient(baseURL: baseAuthURL, configuration: configuration)
        configuration.httpAdditionalHeaders?[APIConstants.accept] = APIConstants.applicationJSON
        authManager = SessionManager(configuration: configuration)
        authManager.adapter = pearsonClient
    }
    
    func configureCourseManager(baseCourseURL: URL,  configuration: URLSessionConfiguration = .default) {
        self.baseCourseURL = baseCourseURL
        configuration.httpAdditionalHeaders?[APIConstants.accept] = APIConstants.applicationJSON
        courseManager = SessionManager(configuration: configuration)
        courseManager.adapter = pearsonClient
    }
    
    func login(userName: String, password: String, completion: @escaping (Error?) -> Void) -> DataRequest {
        let loginEndpoint = LoginEndpoint(userName: userName, password: password)

        return authManager.request(baseAuthURL, endpoint: loginEndpoint, completion: { [weak self] (credentials, error) in
            self?.pearsonClient.credentials = Credentials(accessToken: credentials?.accessToken)
            completion(error)
        })
    }
    
    func getUser(completion: @escaping (UserProfile? ,Error?) -> Void) -> DataRequest {
        let userEndpoint = UserEndpoint()
        
        return authManager.request(baseAuthURL, endpoint: userEndpoint, completion: { (userProfile, error) in
            
            if let mainSchool = userProfile?.user?.getMainSchool(),
                let serviceURLString = mainSchool.links?.serviceLink,
                let serviceURL = URL(string: serviceURLString) {
                APIClient.shared.configureCourseManager(baseCourseURL: serviceURL)
            }
            
            completion(userProfile, error)
        })
    }
    
    func getCourses(schoolId: String, completion: @escaping ([Course]?, Error?) -> Void) -> DataRequest {
        let coursesEndpoint = CoursesEndpoint(schoolId: schoolId)
        
        return courseManager.request(baseCourseURL, endpoint: coursesEndpoint, completion: { (courses, error) in
            completion(courses, error)
        })
    }
    
    func logout(completion: @escaping (Error?) -> Void) -> DataRequest {
        let logoutEndpoint = LogoutEndpoint()
        return authManager.request(baseAuthURL, endpoint: logoutEndpoint, completion: { (response, error) in
            completion(error)
        })
    }
}
