//
//  SearchResultsController.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2017-12-18.
//  Copyright © 2017 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultsController.didCancelSearch))
    }
    
    func didCancelSearch() {
        
    }
}
