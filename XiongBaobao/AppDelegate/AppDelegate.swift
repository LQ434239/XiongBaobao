//
//  AppDelegate.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/9/28.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        self.window?.rootViewController = XBBTabBarController()
        self.window?.backgroundColor = kWhite
        self.window?.makeKeyAndVisible()
        
        ConfigurationManager.setLaunchOption()
//        XBBProgressHUD.showLoadingWithStatus(status: "法第三发的说法")
//        XBBProgressHUD.showSuccessWithStatus(status: "法第三发的说法")
//        XBBProgressHUD.showText(text: "法第三发的说法")
//        XBBProgressHUD.showErrorWithStatus(status: "辅导费抖擞地发挥")
        
         DispatchQueue.main
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }
}

