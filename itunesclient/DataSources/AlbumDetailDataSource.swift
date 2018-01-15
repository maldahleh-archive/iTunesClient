//
//  AlbumDetailDataSource.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-15.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import Foundation
import UIKit

class AlbumDetailDataSource: NSObject, UITableViewDataSource {
    private let songs: [Song]
    
    init(songs: [Song]) {
        self.songs = songs
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0: return "Tracks"
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return songs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SongCell.ReuseIdentifier, for: indexPath) as! SongCell
        
        let song = songs[indexPath.row]
        let viewModel = SongViewModel(song: song)
        
        cell.configure(with: viewModel)
        
        return cell
    }
}
