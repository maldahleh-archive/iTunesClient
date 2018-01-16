//
//  Endpoint.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-15.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
    var queryItems: [URLQueryItem] { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        components.queryItems = queryItems
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        
        return URLRequest(url: url)
    }
}

enum Itunes {
    case search(term: String, mediaType: ItunesMedia?)
    case lookup(id: Int, entity: ItunesEntity?)
}

extension Itunes: Endpoint {
    var base: String {
        return "https://itunes.apple.com"
    }
    
    var path: String {
        switch self {
        case .search: return "/search"
        case .lookup: return "/lookup"
        }
    }
    
    var queryItems: [URLQueryItem] {
        switch self {
        case .search(let term, let type):
            var result = [URLQueryItem]()
            
            let searchTermItem = URLQueryItem(name: "term", value: term)
            result.append(searchTermItem)
            
            if let type = type {
                let mediaTypeItem = URLQueryItem(name: "media", value: type.description)
                result.append(mediaTypeItem)
                
                if let entityQueryItem = type.entityQueryItem {
                    result.append(entityQueryItem)
                }
                
                if let attributeQueryItem = type.attributeQueryItem {
                    result.append(attributeQueryItem)
                }
            }
            
            return result
        case .lookup(let id, let entity):
            return [
                URLQueryItem(name: "id", value: id.description),
                URLQueryItem(name: "entity", value: entity?.entityName)
            ]
        }
    }
}
