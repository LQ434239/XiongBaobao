//
//  NSObject+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

extension NSObject {
    static func currentController() -> UIViewController {
        var vc = UIApplication.shared.keyWindow?.rootViewController
        if (vc?.isKind(of: UITabBarController.self))! {
            vc = (vc as! UITabBarController).selectedViewController
        } else if (vc?.isKind(of: UINavigationController.self))!{
            vc = (vc as! UINavigationController).visibleViewController
        } else if ((vc?.presentedViewController) != nil) {
            vc = vc?.presentedViewController
        }
        return vc!
    }
    
    static func currentNavigationController() -> UINavigationController {
        return (currentController().navigationController)!
    }
}
