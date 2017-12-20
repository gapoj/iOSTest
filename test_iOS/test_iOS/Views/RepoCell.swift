//
//  RepoCell.swift
//  test_iOS
//
//  Created by Guillermo Apoj on 20/12/17.
//  Copyright © 2017 Guillermo Apoj. All rights reserved.
//

import UIKit

class RepoCell: UITableViewCell {
    @IBOutlet weak var nameLbl: UILabel!
    @IBOutlet weak var starsLbl: UILabel!
    @IBOutlet weak var descriptionLbl: UILabel!
    
    var viewModel: RepoCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    private func bindViewModel() {
        nameLbl?.text = viewModel?.name
        starsLbl?.text = viewModel?.stars
        descriptionLbl?.text = viewModel?.description
    }
}
