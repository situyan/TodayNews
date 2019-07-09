//
//  BaseViewController.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/9.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    
    private var _nbTranslucent: Bool
    var nbTranslucent: Bool {
        get {
            return _nbTranslucent
        }
        set {
            _nbTranslucent = newValue
            self.navigationController?.navigationBar.isTranslucent = newValue
        }
    }
    var enablePopGesture: Bool  /// 是否可侧滑返回
    
    //报错：Initializer does not override a designated initializer from its superclass
    //报错Must call a designated initializer of the superclass 'UIViewController'
    //复写父类初始化方法init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)即可，UIViewController中初始化方法会调用其父类的初始化方法，向上递归到基类的初始化方法init()
    //    override init() {
    //        self.enablePopGesture = true
    //        self.nbHidden = false
    //        self.nbTranslucent = true
    //        super.init()
    //    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.enablePopGesture = true
        self._nbTranslucent = false
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.enablePopGesture = true //默认支持侧滑手势
        self.nbTranslucent = false //默认禁止毛玻璃效果
        
        /**
         今日头条：
         https://ke.qq.com/course/281908#tuin=1c8f38f4
         https://ke.qq.com/course/281908#tuin=1c8f38f4
         
         Pch:
         https://www.cnblogs.com/hero11223/p/7363343.html
         
         
         */
    }
    
}
