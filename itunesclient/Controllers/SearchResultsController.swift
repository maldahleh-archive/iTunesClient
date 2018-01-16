//
//  SearchResultsController.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2017-12-18.
//  Copyright © 2017 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {

    let searchController = UISearchController(searchResultsController: nil)
    let dataSource = SearchResultsDataSource()
    let client = ItunesAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultsController.dismissSearchResultsController))
        
        tableView.tableHeaderView = searchController.searchBar
        tableView.dataSource = dataSource
        
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.searchResultsUpdater = self
        
        definesPresentationContext = true
    }
    
    @objc func dismissSearchResultsController() {
        dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showAlbums" {
            if let indexPath = tableView.indexPathForSelectedRow {
                let artist = dataSource.artist(at: indexPath)
                let albumListController = segue.destination as! AlbumListController
                
                client.lookupArtist(withID: artist.id) { artist, error in
                    if let artist = artist {
                        albumListController.artist = artist
                    }
                }
            }
        }
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        client.searchForArtists(withTerm: searchController.searchBar.text!) { [weak self] artists, error in
            if artists.isEmpty || error != nil {
                return
            }
            
            self?.dataSource.update(with: artists)
            self?.tableView.reloadData()
        }
    }
}
