//
//  ItunesAPIClient.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-16.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

typealias ArtistSearchCompletionHandler = ([Artist], ItunesError?) -> Void

class ItunesAPIClient {
    let downloader = JSONDownloader()
    
    func searchForArtists(withTerm term: String, completion: @escaping ArtistSearchCompletionHandler) {
        let endpoint = Itunes.search(term: term, mediaType: .music(entity: .musicArtist, attribute: .artistTerm))
        
        let task = downloader.jsonTask(with: endpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion([], error!)
                    return
                }
                
                guard let results = json["results"] as? [JSON] else {
                    completion([], .jsonParsingFailure(message: "JSON does not contain results"))
                    return
                }
                
                let artists = results.flatMap { Artist(json: $0) }
                completion(artists, nil)
            }
        }
        
        task.resume()
    }
}
