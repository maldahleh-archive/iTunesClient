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
    
    var dataSource = AlbumListDataSource(albums: [])
    
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
                album.songs = Stub.songs
                
                let destination = segue.destination as! AlbumDetailController
                destination.album = album
            }
        }
    }
}
