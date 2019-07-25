//
//  MoreLoginVC.swift
//  TodayNews
//
//  Created by shi_mhua on 2019/7/17.
//  Copyright © 2019 chisalsoft. All rights reserved.
//

import UIKit
import IBAnimatable

class MoreLoginVC: AnimatableModalViewController, StoryboardProtocol {
    
    @IBOutlet weak var loginCloseButton: UIButton!
    /// 顶部标题
    @IBOutlet weak var topLabel: UILabel!
    /// 手机号 view
    @IBOutlet weak var mobileView: AnimatableView!
    /// 验证码 view
    @IBOutlet weak var passwrodView: AnimatableView!
    /// 发送验证码 view
    @IBOutlet weak var sendVerifyView: UIView!
    /// 找回密码 view
    @IBOutlet weak var findPasswordView: UIView!
    /// 发送验证码按钮
    @IBOutlet weak var sendVerifyButton: UIButton!
    /// 手机号 输入框
    @IBOutlet weak var mobileTextField: UITextField!
    /// 找回密码 按钮
    @IBOutlet weak var findPasswordButton: UIButton!
    /// 密码输入框
    @IBOutlet weak var passwordtextField: UITextField!
    /// 未注册
    @IBOutlet weak var middleTipLabel: UILabel!
    /// 进入头条
    @IBOutlet weak var enterTouTiaoButton: AnimatableButton!
    /// 阅读条款
    @IBOutlet weak var readLabel: UILabel!
    /// 阅读按钮
    @IBOutlet weak var readButton: UIButton!
    /// 帐号密码登录
    @IBOutlet weak var loginModeButton: UIButton!
    
    @IBOutlet weak var wechatLoginButton: UIButton!
    
    @IBOutlet weak var qqLoginButton: UIButton!
    
    @IBOutlet weak var tianyiLoginButton: UIButton!
    
    @IBOutlet weak var mailLoginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        loginModeButton.setTitle("免密码登录", for: .selected)
    }
    
    /// 账号密码登录
    @IBAction func loginModeButtonClicked(_ sender: UIButton) {
//        loginModeButton.isSelected = !sender.isSelected
        sender.isSelected = !sender.isSelected
        sendVerifyView.isHidden = sender.isSelected
        findPasswordView.isHidden = !sender.isSelected
        middleTipLabel.isHidden = sender.isSelected
        passwordtextField.placeholder = sender.isSelected ? "密码" : "请输入验证码"
        topLabel.text = sender.isSelected ? "帐号密码登录" : "登录你的头条，精彩永不消失"
    }
    
    /// 点击阅读协议按钮
    @IBAction func readAgreementsAndTermsClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
    }
    
    /// 点击关闭按钮
    @IBAction func moreLoginPageClosedClicked(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
