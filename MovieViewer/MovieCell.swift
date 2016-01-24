//
//  MovieCell.swift
//  MovieViewer
//
//  Created by Senyang Zhuang on 1/24/16.
//  Copyright © 2016 codepath. All rights reserved.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var posterView: UIImageView!
    
    
    @IBOutlet weak var overviewLabel: UILabel!

    
    override func awakeFromNib() {
        weak var posterView: UIView!
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
