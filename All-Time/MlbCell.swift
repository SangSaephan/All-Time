//
//  MlbCell.swift
//  All-Time
//
//  Created by Sang Saephan on 2/7/18.
//  Copyright © 2018 Sang Saephan. All rights reserved.
//

import UIKit
import ChameleonFramework

class MlbCell: UITableViewCell {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = UIColor.clear
        
        nameLabel.textColor = ContrastColorOf(UIColor.flatNavyBlue, returnFlat: true)
        statLabel.textColor = ContrastColorOf(UIColor.flatNavyBlue, returnFlat: true)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
