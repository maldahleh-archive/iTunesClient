//
//  ArtworkDownloader.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-16.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation
import UIKit

class ArtworkDownloader: Operation {
    let album: Album
    
    init(album: Album) {
        self.album = album
        super.init()
    }
    
    override func main() {
        if isCancelled { return }
        
        guard let url = URL(string: album.artworkUrl) else { return }
        
        do {
            let imageData = try Data(contentsOf: url)
            
            if isCancelled { return }
            
            if imageData.count > 0 {
                album.artwork = UIImage(data: imageData)
                album.artworkState = .downloaded
            } else {
                album.artworkState = .failed
            }
        } catch {
            return
        }
    }
}
