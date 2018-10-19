//
//  XBBTabBarViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setValue(XBBTabBar(), forKey: "tabBar")
        
        setupChildControllers()
    }
    
    func setupChildControllers() {
        addChildController(controller: XBBHomeViewController(), title: "首页", image: "home_tab_nor", selectedImage: "home_tab_down")
        addChildController(controller: XBBMineViewController(), title: "我的", image: "mine_tab_nor", selectedImage: "mine_tab_down")
    }
    
    private func addChildController(controller: UIViewController, title: String, image: String, selectedImage: String) {
//        controller.title = title
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage.init(named: image)
        controller.tabBarItem.selectedImage = UIImage.init(named: image)
        controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kTextColor9], for: .normal)
        controller.tabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: kThemeColor], for: .selected)
        
        let nav = XBBNavigationController.init(rootViewController: controller)
        self.addChild(nav)
    }
}
