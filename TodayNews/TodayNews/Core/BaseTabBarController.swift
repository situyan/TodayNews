//
//  BaseTabBarController.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/9.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit

class BaseTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tabBar.isTranslucent = false
        let tabbar = UITabBar.appearance()
        tabbar.theme_tintColor = "colors.tabbarTintColor"
        tabbar.theme_barTintColor = "colors.cellBackgroundColor"
        initialVC()
        NotificationCenter.default.addObserver(self, selector: #selector(receiveDayOrNightButtonClicked), name: NSNotification.Name(rawValue: "dayOrNightButtonClicked"), object: nil)
    }
    
    //MARK: 初始化VC
    func initialVC() {
        addChildVC(HomePageVC(), title: "首页", imageName: "home")
        addChildVC(WatermelonVideoVC(), title: "视频", imageName: "video")
        addChildVC(ShortVideoVC(), title: "小视频", imageName: "huoshan")
        addChildVC(MineVC(), title: "我的", imageName: "mine")
        
        setValue(BaseTabBar(), forKey: "tabBar")
    }
    
    func addChildVC(_ childController: UIViewController, title: String, imageName: String) {
        // 设置 tabbar 文字和图片
        if UserDefaults.standard.bool(forKey: isNight) {
            setNightChildController(controller: childController, imageName: imageName)
        }else {
            setDayChildController(controller: childController, imageName: imageName)
        }
        childController.title = title
        childController.navigationItem.title = title
        addChild(BaseNavigationController(rootViewController: childController))
    }
    
    @objc func receiveDayOrNightButtonClicked(notification: Notification) {
        let selected = notification.object as! Bool
        if selected {
            //设置为日间
            for childController in children {
                switch childController.title! {
                case "首页":
                    setNightChildController(controller: childController, imageName: "home")
                case "视频":
                    setNightChildController(controller: childController, imageName: "video")
                case "小视频":
                    setNightChildController(controller: childController, imageName: "huoshan")
                case "我的":
                    setNightChildController(controller: childController, imageName: "mine")
                case "":
                    setNightChildController(controller: childController, imageName: "redpackage")
                default:
                    break
                }
            }
        }else {
            //设置为夜间
            for childController in children {
                switch childController.title! {
                case "首页":
                    setDayChildController(controller: childController, imageName: "home")
                case "视频":
                    setDayChildController(controller: childController, imageName: "video")
                case "小视频":
                    setDayChildController(controller: childController, imageName: "huoshan")
                case "我的":
                    setDayChildController(controller: childController, imageName: "mine")
                case "":
                    setDayChildController(controller: childController, imageName: "redpackage")
                default:
                    break
                }
            }
        }
    }
    
    /// 设置夜间控制器
    private func setNightChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_night_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_night_32x32_")
    }
    /// 设置日间控制器
    private func setDayChildController(controller: UIViewController, imageName: String) {
        controller.tabBarItem.image = UIImage(named: imageName + "_tabbar_32x32_")
        controller.tabBarItem.selectedImage = UIImage(named: imageName + "_tabbar_press_32x32_")
    }
}
