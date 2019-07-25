//
//  NoLoginHeaderView.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/16.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit
import IBAnimatable
import SwiftTheme

/// headerView高度
let kMyHeaderViewHeight: CGFloat = 280

class NoLoginHeaderView: UIView, NibLoadable {

    /**
     1、stackView
     2、headerView高度变化
     3、SwiftTheme
     MyTheme
    */
    /// 背景图片
    @IBOutlet weak var bgImageView: UIImageView!
    /// 手机按钮
    @IBOutlet weak var mobileButton: UIButton!
    /// 微信按钮
    @IBOutlet weak var wechatButton: UIButton!
    /// QQ 按钮
    @IBOutlet weak var qqButton: UIButton!
    /// 新浪按钮
    @IBOutlet weak var sinaButton: UIButton!
    /// 更多登录方式按钮
    @IBOutlet weak var moreLoginButton: AnimatableButton!
    /// 收藏按钮
    @IBOutlet weak var favoriteButton: UIButton!
    /// 历史按钮
    @IBOutlet weak var historyButton: UIButton!
    /// 日间/夜间 按钮
    @IBOutlet weak var dayOrNightButton: UIButton!
    
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bgImageViewConstraintTopY: NSLayoutConstraint!
    
    /// 点击了日间 夜间按钮
    @IBAction func dayOrNightButtonClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        MyTheme.switchNight(sender.isSelected)
        UserDefaults.standard.set(sender.isSelected, forKey: isNight)
        NotificationCenter.default.post(name: Notification.Name(rawValue: "dayOrNightButtonClicked"), object: sender.isSelected)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bgImageViewConstraintTopY.constant = -20 - MoreNavigationBarHeight
        
        /// 设置主题
//        ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        mobileButton.theme_setImage("images.mobileButton", forState: .normal)
        wechatButton.theme_setImage("images.wechatButton", forState: .normal)
        qqButton.theme_setImage("images.qqButton", forState: .normal)
        sinaButton.theme_setImage("images.sinaButton", forState: .normal)
        favoriteButton.theme_setImage("images.favoriteButton", forState: .normal)
        historyButton.theme_setImage("images.historyButton", forState: .normal)
        dayOrNightButton.theme_setImage("images.dayOrNightButton", forState: .normal)
        dayOrNightButton.setTitle("日间", for: .normal)
        dayOrNightButton.setTitle("夜间", for: .selected)
        moreLoginButton.theme_backgroundColor = "colors.moreLoginButton"
        moreLoginButton.theme_setTitleColor("colors.moreLoginText", forState: .normal)
        favoriteButton.theme_setTitleColor("colors.black", forState: .normal)
        historyButton.theme_setTitleColor("colors.black", forState: .normal)
        dayOrNightButton.theme_setTitleColor("colors.black", forState: .normal)
        bottomView.theme_backgroundColor = "colors.cellBackgroundColor"
    }
}
