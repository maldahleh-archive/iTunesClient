//
//  JSONDownloader.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-15.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

typealias JSON = [String: AnyObject]
typealias JSONTaskCompletionHandler = (JSON?, ItunesError?) -> Void

class JSONDownloader {
    let session: URLSession
    
    init() {
        session = URLSession(configuration: .default)
    }
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            if httpResponse.statusCode == 200 {
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? JSON
                        completion(json, nil)
                    } catch {
                        completion(nil, .jsonConversionFailure)
                    }
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
    }
}
