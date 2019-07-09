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
        tabbar.tintColor = RGBColor(r: 245, g: 90, b: 93)
        
        initialVC()
    }
    
    //MARK: 初始化VC
    func initialVC() {
        self.addChildVC(HomePageVC(), title: "首页", image: UIImage(named: "home_tabbar_32x32_"), selectedImage: UIImage(named: "home_tabbar_press_32x32_"))
        self.addChildVC(WatermelonVideoVC(), title: "视频", image: UIImage(named: "video_tabbar_32x32_"), selectedImage: UIImage(named: "video_tabbar_press_32x32_"))
        self.addChildVC(ShortVideoVC(), title: "小视频", image: UIImage(named: "huoshan_tabbar_32x32_"), selectedImage: UIImage(named: "huoshan_tabbar_press_32x32_"))
        self.addChildVC(MineVC(), title: "我的", image: UIImage(named: "mine_tabbar_32x32_"), selectedImage: UIImage(named: "mine_tabbar_press_32x32_"))
    }
    
    func addChildVC(_ childVC: UIViewController, title: String?, image: UIImage?, selectedImage: UIImage?) {
        childVC.navigationItem.title = title
        let tabBarItem: UITabBarItem = UITabBarItem(title: title, image: image?.withRenderingMode(.alwaysOriginal), selectedImage: selectedImage?.withRenderingMode(.alwaysOriginal));
        //        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(displayP3Red: 102.0/255, green: 102.0/255, blue: 102.0/255, alpha: 1.0)], for: .normal)
        //        tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: .selected)
        childVC.tabBarItem = tabBarItem;
        let naviVC: BaseNavigationController = BaseNavigationController(rootViewController: childVC)
        self.addChild(naviVC)
    }
    
}
