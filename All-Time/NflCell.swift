//
//  NflCell.swift
//  All-Time
//
//  Created by Sang Saephan on 2/3/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit

class NflCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
