//
//  SongCellViewModel.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-15.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation

struct SongViewModel {
    let title: String
    let runtime: String
}

extension SongViewModel {
    init(song: Song) {
        self.title = song.censoredName
        
        let timeInSeconds = song.trackTime / 1000
        let minutes = timeInSeconds / 60 % 60
        let seconds = timeInSeconds % 60
        
        self.runtime = "\(minutes): \(seconds)"
    }
}
