//
//  CodeMessage.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/2.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

class CodeMessage {
    
    static let shard = CodeMessage()
    
    private func showLogin() {
        let status = UserDefaults.standard.bool(forKey: "showLogin")
        if !status {
            UserManager.shard.logout()
            NSObject.showAlertView(title: "提示", message: "登录失效", confirmTitle: "确定") { (action) in
                let nav = XBBNavigationController(rootViewController: XBBLoginViewController())
                UIApplication.shared.keyWindow?.rootViewController = nav
            }
        }
        UserDefaults.standard.set(true, forKey: "showLogin")
    }
    
    private func showIdentityChange() {
        NSObject.showAlertView(title: "提示", message: "您的身份已改变", confirmTitle: "确定") { (action) in
            NSObject.currentNavigationController().popToRootViewController(animated: false)
        }
    }
}
