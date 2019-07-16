//
//  SwiftTheme.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/16.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import Foundation
import SwiftTheme

enum MyTheme: Int {
    /// 白天标识
    case day = 0
    /// 黑夜标识
    case night = 1
    /// 定义之前的标识
    static var before = MyTheme.day
    /// 定义现在的标识
    static var current = MyTheme.night
    
    /// 主要的类ThemeManager，根据plist来使用
    static func switchTo(_ theme: MyTheme) {
        /// 替换参数
        before = current
        current = theme
        
        /// 设置主题
        switch theme {
        case .day:
            ThemeManager.setTheme(plistName: "default_theme", path: .mainBundle)
        default:
            ThemeManager.setTheme(plistName: "night_theme", path: .mainBundle)
        }
    }
    
    //// 选择夜间主题
    static func switchNight(_ isToNight: Bool) {
        switchTo(isToNight ? .night : .day)
    }
    /// 判断当前是否夜间主题
    static func isNight() -> Bool {
        return current == .night
    }
    
}
