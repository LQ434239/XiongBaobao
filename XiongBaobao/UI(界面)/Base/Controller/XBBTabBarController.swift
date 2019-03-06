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
        
        setValue(XBBTabBar(), forKey: "tabBar")
        
        xbb_setupChildControllers()
    }
    
    private func xbb_setupChildControllers() {
        xbb_addChildController(controller: XBBHomeViewController(), title: "首页", image: "home_tab_nor", selectedImage: "home_tab_down")
        
        let isB = UserDefaults.standard.integer(forKey: "isB")
        let vc = isB == 1 ? XBBBaseContractViewController(): XBBMyContractViewController()
        xbb_addChildController(controller: vc, title: "合同", image: "mine_tab_nor", selectedImage: "mine_tab_down")
        
//        addChildController(controller: XBBMallViewController(), title: "产品", image: "mine_tab_nor", selectedImage: "mine_tab_down")
        
        xbb_addChildController(controller: XBBMineViewController(), title: "我的", image: "mine_tab_nor", selectedImage: "mine_tab_down")
    }
    
    private func xbb_addChildController(controller: UIViewController, title: String, image: String, selectedImage: String) {
        controller.title = title
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(named: image)
        controller.tabBarItem.selectedImage = UIImage(named: image)
        controller.tabBarItem.setTitleTextAttributes([.foregroundColor: kTextColor9], for: .normal)
        controller.tabBarItem.setTitleTextAttributes([.foregroundColor: kThemeColor], for: .selected)
        
        let nav = XBBNavigationController.init(rootViewController: controller)
        addChild(nav)
    }
}
