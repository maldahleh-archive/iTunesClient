//
//  AlbumDetailController.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-08.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class AlbumDetailController: UITableViewController {
    var album: Album? {
        didSet {
            configure(with: album!)
            
            dataSource.update(with: album!.songs)
            tableView.reloadData()
        }
    }
    
    let dataSource = AlbumDetailDataSource(songs: [])
    
    @IBOutlet weak var artworkView: UIImageView!
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet weak var albumGenreLabel: UILabel!
    @IBOutlet weak var albumReleaseDateLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = dataSource
    }
    
    func configure(with album: Album) {
        let viewModel = AlbumDetailViewModel(album: album)
        
        // TODO: Add implementation for artwork
        albumTitleLabel.text = viewModel.title
        albumGenreLabel.text = viewModel.genre
        albumReleaseDateLabel.text = viewModel.releaseDate
    }
}
