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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Table View Delegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return Constants.AlbumCellHeight
    }
}
