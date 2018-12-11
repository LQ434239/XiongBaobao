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

    var orientationMask: UIInterfaceOrientationMask = .portrait {
        didSet {
            if orientationMask.contains(.portrait) {
                return UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
            } else {
                return UIDevice.current.setValue(UIInterfaceOrientation.landscapeLeft.rawValue, forKey: "orientation")
            }
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds)
        
        if (UserDefaults.standard.string(forKey: "accessToken") == nil) {
            self.window?.rootViewController = XBBNavigationController.init(rootViewController: XBBLoginViewController())
        } else {
            self.window?.rootViewController = XBBTabBarController()
        }
        
        self.window?.backgroundColor = UIColor.white
        self.window?.makeKeyAndVisible()
        
        XBBConfigurationManager.setLaunchOption()
        XBBStartAPIManager.setLaunchOption()
        
        UIButton.methodExchange()
        
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
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationMask
    }
}

