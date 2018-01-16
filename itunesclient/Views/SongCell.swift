//
//  SongCell.swift
//  itunesclient
//
//  Created by Mohammed Al-Dahleh on 2018-01-15.
//  Copyright © 2018 Mohammed Al-Dahleh. All rights reserved.
//

import UIKit

class SongCell: UITableViewCell {
    static let ReuseIdentifier = "SongCell"
    
    @IBOutlet weak var songNameLabel: UILabel!
    @IBOutlet weak var songTimeLabel: UILabel!

    func configure(with viewModel: SongViewModel) {
        songNameLabel.text = viewModel.title
        songTimeLabel.text = viewModel.runtime
    }
}
