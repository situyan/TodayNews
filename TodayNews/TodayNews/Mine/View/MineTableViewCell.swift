//
//  MineTableViewCell.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/15.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit

class MineTableViewCell: UITableViewCell, RegisterCellOrNib {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
