//
//  XBBNavigationViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        WRNavigationBar.defaultShadowImageHidden = true
        WRNavigationBar.defaultNavBarTintColor = kTextColor3
        
        self.navigationBar.shadow(radius: 1, opacity: 0.2)
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
