//
//  BaseTabBar.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/10.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit

class BaseTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        theme_tintColor = "colors.tabbarTintColor"
        theme_barTintColor = "colors.cellBackgroundColor"
        addSubview(publishButton)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var publishButton: UIButton = {
        let button = UIButton(type: .custom)
        if UserDefaults.standard.bool(forKey: isNight) {
            button.setImage(UIImage(named: "feed_publish_night_44x44_"), for: .normal)
            button.setImage(UIImage(named: "feed_publish_press_night_44x44_"), for: .selected)
        }else {
            button.setImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
            button.setImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
        }
        button.sizeToFit()
        return button
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        //设置发布按钮
        publishButton.center = CGPoint(x: frame.width*0.5, y: frame.height*0.5 - 7 - SafeAreaBottomHeight*0.7)
        
        let btWidth: CGFloat = frame.width*0.2
        let btHeight: CGFloat = frame.height - SafeAreaBottomHeight
        var originX: CGFloat = 0
        
        var index = 0
        for button in subviews {
            if !button.isKind(of: NSClassFromString("UITabBarButton")!) {
                continue
            }
            originX = btWidth*CGFloat(index > 1 ? index + 1 : index)
            button.frame = CGRect(x: originX, y: 0, width: btWidth, height: btHeight)
            index += 1
        }
    }
    
    /// 设置夜间
    func setNightBaseTabBar() {
        publishButton.setImage(UIImage(named: "feed_publish_night_44x44_"), for: .normal)
        publishButton.setImage(UIImage(named: "feed_publish_press_night_44x44_"), for: .selected)
    }
    /// 设置日间
    func setDayChildBaseTabBar() {
        publishButton.setImage(UIImage(named: "feed_publish_44x44_"), for: .normal)
        publishButton.setImage(UIImage(named: "feed_publish_press_44x44_"), for: .selected)
    }    
}
