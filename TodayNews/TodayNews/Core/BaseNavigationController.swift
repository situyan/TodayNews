//
//  BaseNavigationController.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/9.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit

class BaseNavigationController: UINavigationController, UINavigationControllerDelegate {
    
    var popGesture: UIGestureRecognizer?
    var enablePopGesture: Bool = true
    
    //    //MARK: - 初始化
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController);
        popGesture = interactivePopGestureRecognizer
        delegate = self
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    //    override init(navigationBarClass: AnyClass?, toolbarClass: AnyClass?) {
    //        super.init(navigationBarClass: navigationBarClass, toolbarClass: toolbarClass)
    //        popGesture = interactivePopGestureRecognizer
    //        delegate = self
    //    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        //记录系统手势代理
        self.popGesture = self.interactivePopGestureRecognizer
        self.delegate = self
        self.enablePopGesture = true
    }
    
    //MARK: - 隐藏标签栏TabBar
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            //            viewController.hidesBottomBarWhenPushed = true;
            //            print("--------->>>>>>>")
        }
        super.pushViewController(viewController, animated: animated)
    }
    
    //MARK: - UINavigationControllerDelegate
    func navigationController(_ navigationController: UINavigationController, didShow viewController: UIViewController, animated: Bool) {
        //更新栈先进后出方式
        if self.viewControllers[0].isEqual(viewController) { //根控制器
            //还原代理
            self.interactivePopGestureRecognizer?.delegate = self.popGesture as? UIGestureRecognizerDelegate
        }else {
            //清空手势代理就能实现滑动返回
            self.interactivePopGestureRecognizer?.delegate = nil
        }
        //如果当前控制器为根控制器，则使手势失效，不然手势会将根控制器移除
        if self.viewControllers.count <= 1 {
            self.interactivePopGestureRecognizer?.isEnabled = false
        }else {
            if viewController is BaseViewController {
                let theVC: BaseViewController = viewController as! BaseViewController
                self.interactivePopGestureRecognizer?.isEnabled = theVC.enablePopGesture
            }else {
                self.interactivePopGestureRecognizer?.isEnabled = self.enablePopGesture
            }
        }
    }
}
