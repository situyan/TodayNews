//
//  SettingTableViewCell.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/25.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit
import Kingfisher

class SettingTableViewCell: UITableViewCell, RegisterCellOrNib {

    /// 标题
    @IBOutlet weak var titleLabel: UILabel!
    /// 副标题
    @IBOutlet weak var subtitleLabel: UILabel!
    /// 右边标题
    @IBOutlet weak var rightTitleLabel: UILabel!
    
    @IBOutlet weak var arrowImageView: UIImageView!
    
    @IBOutlet weak var switchView: UISwitch!
    
    @IBOutlet weak var bottomLine: UIView!
    /// 副标题高度约束
    @IBOutlet weak var subtitleConstraintHeight: NSLayoutConstraint!
    
    var settingModel: SettingModel = SettingModel() {
        didSet {
            titleLabel.text = settingModel.title
            subtitleLabel.text = settingModel.subtitle
            rightTitleLabel.text = settingModel.rightTitle
            arrowImageView.isHidden = settingModel.isHiddenRightArrow
            switchView.isHidden = settingModel.isHiddenSwitch
            if !settingModel.isHiddenSubtitle {
                subtitleConstraintHeight.constant = 20
                layoutIfNeeded()
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
extension SettingTableViewCell {
    //从沙盒中获取缓存数据的大小
    func calculateDiskCashSize() {
        let cache = KingfisherManager.shared.cache
        cache.calculateDiskCacheSize { (size) in
            //转换成 M
            let sizeM = Double(size) / 1024.0 / 1024.0
            self.rightTitleLabel.text = String(format: "%.2fM", sizeM)
        }
    }
    
    /// 非 WiFi 网络播放提醒
    func setupPlayNoticeAlertController() {
        let alertController = UIAlertController(title: "非 WiFi 网络播放提醒", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let everyAction = UIAlertAction(title: "每次提醒", style: .default) { (_) in
            self.rightTitleLabel.text = "每次提醒"
        }
        let onceAction = UIAlertAction(title: "提醒一次", style: .default) { (_) in
            self.rightTitleLabel.text = "提醒一次"
        }
        alertController.addAction(cancelAction)
        alertController.addAction(everyAction)
        alertController.addAction(onceAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
    
    /// 弹出清理缓存的提示框
    func clearCacheAlertController() {
        let alertController = UIAlertController(title: "确定清除所有缓存？问答草稿、离线下载及图片均会被清除", message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        let okAction = UIAlertAction(title: "确定", style: .default) { (_) in
            let cache = KingfisherManager.shared.cache
            cache.clearDiskCache()
            cache.clearMemoryCache()
            self.rightTitleLabel.text = "0.00M"
        }
        alertController.addAction(cancelAction)
        alertController.addAction(okAction)
        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
    }
}
