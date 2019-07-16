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
    /// 右边箭头
    @IBOutlet weak var rightImageView: UIImageView!
    @IBOutlet weak var separatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        /// 设置主题
        titleLabel.theme_textColor = "colors.black"
        subTitleLabel.theme_textColor = "colors.cellRightTextColor"
        rightImageView.theme_image = "images.cellRightArrow"
        separatorView.theme_backgroundColor = "colors.separatorViewColor"
        theme_backgroundColor = "colors.cellBackgroundColor"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
