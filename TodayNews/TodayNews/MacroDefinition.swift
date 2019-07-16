//
//  MacroDefinition.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/9.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import Foundation
import UIKit


/**
 * 网络相关
 * 外网：skey: iOS20190621UUY8HDO0S1@Bob    测试: testSkey
 */
let apskey = "testSkey"
let SUCCESS = "success"
let interfaceVersion = "interfaceVersion"


/**
 * 系统相关
 */
// 屏幕高度
let SCREEN_WIDTH = UIScreen.main.bounds.size.width
// 屏幕宽度
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height
// 系统版本
let IOS_VERSION = Float(UIDevice.current.systemVersion)

//颜色值
extension UIColor {
    convenience init(r red:CGFloat, g green:CGFloat, b blue:CGFloat, a alpha: CGFloat = 1.0) {
        if #available(iOS 10.0, *) {
            self.init(displayP3Red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha) //该方法能提升性能
        } else {
            self.init(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: alpha)
        }
    }
}
/// 默认颜色值
let DefaultColor = UIColor(r: 247, g: 247, b: 247)


//
//public func RGBColor(r red:CGFloat, g green:CGFloat, b blue:CGFloat) -> UIColor {
//    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
//}
//
////@available(iOS 10.0, *)  if #available(iOS 10.0, *)
//public func RGBColor(r red:CGFloat, g green:CGFloat, b blue:CGFloat, a alpha:CGFloat) -> UIColor {
//    return UIColor(red: red/255.0, green: green/255.0, blue: blue/255.0, alpha: 1.0)
//}


/**
 * 适配 相关
 */
// 判断是iPhoneX 的宏
let is_iPhoneX = (SCREEN_HEIGHT >= 812.0) ? true : false
// 判断是 小屏 的宏 (iPhone 5\SE)
let is_iPhoneMin = (SCREEN_HEIGHT <= 568.0) ? true : false
// 顶部和底部安全区域宏
let SafeAreaTopHeight = (SCREEN_HEIGHT >= 812.0) ? 88.0 : 64.0
let SafeAreaBottomHeight = (SCREEN_HEIGHT >= 812.0) ? 34.0 : 0
// 状态栏高度
let TopStatuBarHeight = (SCREEN_HEIGHT >= 812.0) ? 44.0 : 20.0
// iPhone X系列机型导航栏多出高度
let MoreNavigationBarHeight = (SCREEN_HEIGHT >= 812.0) ? 24.0 : 0
// 高度比例（原值4.7英寸iPhone6、S系列）
let HeightRatio = ((SCREEN_HEIGHT <= 736.0 ? SCREEN_HEIGHT : (SCREEN_HEIGHT == 896.0 ? 736.0 : 667.0) ) / 667.0)
// 宽度比例（原值4.7英寸iPhone6、S系列）
let WidthRatio = SCREEN_WIDTH / 375.0


/// 全局函数自定义输出  优化性能
//func DPrint(_ item: @autoclosure () -> Any) {
//    //https://www.jianshu.com/p/ba7701fa194a
//    #if DEBUG
//    print(item())
//    #endif
//}
// 使用DPrint好处之一： 系统的print打印需要表达式或值为非可选类型，所有会有烦人的警告，消除需要 as 或 ， 而DPrint没有
func DPrint<T>(_ message: T, file: String = #file , line: Int = #line) {
    //https://www.jianshu.com/p/e7219f0f5ac7
    //如果DEBUG存在，就说明是在项目调试下运行程序
    #if DEBUG
        let fileName = (file as NSString).lastPathComponent
        print("\(fileName) : [\(line)] - \(message)")
    #endif
}
