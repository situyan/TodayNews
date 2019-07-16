//
//  NoLoginHeaderView.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/16.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit
import IBAnimatable

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
    
    /// 点击了日间 夜间按钮
    @IBAction func dayOrNightButtonClicked(_ sender: UIButton) {
        
    }
}
