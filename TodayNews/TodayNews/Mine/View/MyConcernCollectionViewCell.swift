//
//  MyConcernCollectionViewCell.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/16.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit
import Kingfisher

class MyConcernCollectionViewCell: UICollectionViewCell, RegisterCellOrNib {
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var vipImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tipsButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImageView.layer.cornerRadius = 20
        avatarImageView.layer.masksToBounds = true
        tipsButton.layer.cornerRadius = 5
        tipsButton.layer.masksToBounds = true
        tipsButton.layer.borderWidth = 1.0
        tipsButton.layer.borderColor = UIColor.white.cgColor
    }

    var myConcern = MyConcern() {
        didSet {
            avatarImageView.kf.setImage(with: URL(string: myConcern.icon))
            nameLabel.text = myConcern.name
            vipImageView.isHidden = !myConcern.is_verify
            tipsButton.isHidden = !myConcern.tips
            vipImageView.image = myConcern.user_auth_info.auth_type == 1 ? UIImage(named: "all_v_avatar_star_16x16_") : UIImage(named: "all_v_avatar_18x18_")
        }
    }
}
