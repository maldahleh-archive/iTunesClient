//
//  ItunesAPIClient.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-16.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

typealias Results = [JSON]

typealias RequestCompletionHandler = (Results?, ItunesError?) -> Void
typealias ArtistSearchCompletionHandler = ([Artist], ItunesError?) -> Void
typealias ArtistLookupCompletionHandler = (Artist?, ItunesError?) -> Void

class ItunesAPIClient {
    let downloader = JSONDownloader()
    
    func searchForArtists(withTerm term: String, completion: @escaping ArtistSearchCompletionHandler) {
        let endpoint = Itunes.search(term: term, mediaType: .music(entity: .musicArtist, attribute: .artistTerm))
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let artists = results.flatMap { Artist(json: $0) }
            completion(artists, nil)
        }
    }
    
    func lookupArtist(withID id: Int, completion: @escaping ArtistLookupCompletionHandler) {
        let endpoint = Itunes.lookup(id: id, entity: MusicEntity.album)
        
        performRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion(nil, error)
                return
            }
            
            guard let artistInfo = results.first else {
                completion(nil, .jsonParsingFailure(message: "Results does not contain artist."))
                return
            }
            
            guard let artist = Artist(json: artistInfo) else {
                completion(nil, .jsonParsingFailure(message: "Could not parse artist."))
                return
            }
            
            let albumResults = results[1..<results.count]
            let albums = albumResults.flatMap { Album(json: $0) }
            artist.albums = albums
            
            completion(artist, nil)
        }
    }
    
    private func performRequest(with endpoint: Endpoint, completion: @escaping RequestCompletionHandler) {
        let task = downloader.jsonTask(with: endpoint.request) { json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error!)
                    return
                }
                
                guard let results = json["results"] as? Results else {
                    completion(nil, .jsonParsingFailure(message: "JSON does not contain results"))
                    return
                }
                
                completion(results, nil)
            }
        }
        
        task.resume()
    }
}
