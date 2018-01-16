//
//  AlbumDetailViewModel.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-15.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation
import UIKit

struct AlbumDetailViewModel {
    let artworkImage: UIImage
    let title: String
    let releaseDate: String
    let genre: String
}

extension AlbumDetailViewModel {
    init(album: Album) {
        self.artworkImage = album.artworkState == .downloaded ? album.artwork! : #imageLiteral(resourceName: "AlbumPlaceholder")
        self.title = album.censoredName
        self.genre = album.primaryGenre.name
        
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "MMM dd, yyyy"
        
        self.releaseDate = formatter.string(from: album.releaseDate)
    }
}
