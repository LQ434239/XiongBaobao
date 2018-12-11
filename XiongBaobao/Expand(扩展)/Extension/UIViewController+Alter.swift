//
//  UIViewController+Alter.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/27.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

extension UIViewController {
    
    static func initializeMethod() {
        let originalSelector = #selector(UIViewController.present(_:animated:completion:))
        let swizzledSelector = #selector(xbb_present(_:animated:completion:))
        let presentV = class_getInstanceMethod(UIViewController.self, originalSelector)
        let xbb_presentV = class_getInstanceMethod(UIViewController.self, swizzledSelector)
        method_exchangeImplementations(presentV!, xbb_presentV!)
    }
    
    @objc fileprivate func xbb_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if viewControllerToPresent.isKind(of: UIAlertController.self) {
            let alter = viewControllerToPresent as! UIAlertController
            if alter.actions.count == 2 {
                let action0 = alter.actions[0]
                action0.setValue(kTextColor6, forKey: "titleTextColor")
                
                let action1 = alter.actions[1]
                action1.setValue(kThemeColor, forKey: "titleTextColor")
            } else if alter.actions.count > 0 {
                let action = alter.actions[0]
                action.setValue(kThemeColor, forKey: "titleTextColor")
            }
            if alter.title == "操作完成" {
                return
            }
        }
        xbb_present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
