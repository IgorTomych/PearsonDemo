//
//  APIResponseSerializing.swift
//  Pearson
//
//  Created by Denys Trush on 11/10/17.
//  Copyright © 2017 itomych studio. All rights reserved.
//

import Alamofire
import Marshal

private let emptyDataStatusCodes: Set<Int> = [204, 205]

// Response serializer to import JSON Object using Marshal and return an object
func APIObjectResponseSerializer<T: Unmarshaling>(type: T.Type) -> DataResponseSerializer<T> {
    return DataResponseSerializer { _, response, data, error in
        do {
            if let error = error { throw error }
            
            if let response = response, emptyDataStatusCodes.contains(response.statusCode) {
                return try .success(type.init(object: [:]))
            }
            
            guard let validData = data, validData.count > 0 else {
                throw APIError.invalidResponse
            }
            let JSON = try JSONSerialization.jsonObject(with: validData, options: [])
            guard let object = JSON as? JSONObject else {
                throw APIError.invalidResponse
            }
            
            return try .success(type.init(object: object))
        } catch {
            return .failure(error as NSError)
        }
    }
}

func APICollectionResponseSerializer<T: Collection>(type: T.Type) -> DataResponseSerializer<T> where T.Iterator.Element: Unmarshaling {
    return DataResponseSerializer { _, _, data, error in
        do {
            if let error = error { throw error }
            
            guard let validData = data, validData.count > 0 else {
                throw APIError.invalidResponse
            }
            let JSON = try JSONSerialization.jsonObject(with: validData, options: [])
            guard let collection = JSON as? [JSONObject] else {
                throw APIError.invalidResponse
            }
            let result = try collection.map({ try T.Iterator.Element.init(object: $0) })
            guard let typedResult = result as? T else {
                fatalError("Unable to transfer typed arrays")
            }
            return .success(typedResult)
        } catch {
            return .failure(error as NSError)
        }
    }
}
