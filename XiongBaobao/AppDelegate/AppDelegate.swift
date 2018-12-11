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
        
        if (UserDefaults.standard.string(forKey: "accessToken") != nil) {
            self.window?.rootViewController = XBBTabBarController()
        } else {
            let nav = XBBNavigationController.init(rootViewController: XBBLoginViewController())
            self.window?.rootViewController = nav
        }
        
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        ConfigurationManager.setLaunchOption()
        StartAPIManager.setLaunchOption()
        
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

