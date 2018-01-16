//
//  AlbumListController.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2017-12-18.
//  Copyright © 2017 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class AlbumListController: UITableViewController {
    private struct Constants {
        static let AlbumCellHeight: CGFloat = 80.0
    }
    
    var artist: Artist? {
        didSet {
            self.title = artist?.name
            
            dataSource.update(with: artist!.albums)
            tableView.reloadData()
        }
    }
    
    let dataSource = AlbumListDataSource(albums: [])
    let client = ItunesAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.AlbumCellHeight
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbum" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let album = dataSource.album(for: indexPath)
                let destination = segue.destination as! AlbumDetailController
                
                client.lookupSongs(withID: album.id) { album, error in
                    guard let album = album else {
                        return
                    }
                    
                    destination.album = album
                    destination.album?.songs = album.songs
                }
            }
        }
    }
}
