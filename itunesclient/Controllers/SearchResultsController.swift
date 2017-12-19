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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultsController.dismissSearchResultsController))
        
        tableView.tableHeaderView = searchController.searchBar
    }
    
    @objc func dismissSearchResultsController() {
        dismiss(animated: true, completion: nil)
    }
}
