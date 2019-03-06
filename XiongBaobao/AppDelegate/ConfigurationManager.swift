//
//  ConfigurationManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ConfigurationManager: NSObject {
    
    static func xbb_setLaunchOption() {
        xbb_initBaseSetup()
        xbb_setSVProgressHUD()
        xbb_setIQKeyboardManager()
    }
    
    static func xbb_initBaseSetup() {
        if #available(iOS 11.0, *) {
//            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
//            UICollectionView.appearance().contentInsetAdjustmentBehavior = .automatic
            
            UITableView.appearance().estimatedRowHeight = 0
            UITableView.appearance().estimatedSectionHeaderHeight = 0
            UITableView.appearance().estimatedSectionFooterHeight = 0
        }
    
        UIButton.appearance().isExclusiveTouch = false //避免在一个界面上同时点击多个UIButton导致同时响应多个方法
        UIBarButtonItem.appearance().setTitleTextAttributes([.foregroundColor: UIColor.clear], for: .normal)
    }
    
    static func xbb_setSVProgressHUD() {
        SVProgressHUD.setDefaultStyle(.dark)
        SVProgressHUD.setDefaultMaskType(.clear)
        SVProgressHUD.setDefaultAnimationType(.native)
        SVProgressHUD.setFont(FontSize(16))
        SVProgressHUD.setShouldTintImages(false)
        SVProgressHUD.setImageViewSize(CGSize(width: CGRatioWidth(40), height: CGRatioWidth(40)))
        SVProgressHUD.setMinimumSize(CGSize(width: CGRatioWidth(95), height: CGRatioWidth(100)))
        SVProgressHUD.setErrorImage(UIImage(named: "HUD_error")!)
        SVProgressHUD.setSuccessImage(UIImage(named: "HUD_success")!)
        SVProgressHUD.setMinimumDismissTimeInterval(1.5)
    }
    
    static func xbb_setIQKeyboardManager() {
//        let manager = IQKeyboardManager.shared
//        manager.enableAutoToolbar = false
//        manager.previousNextDisplayMode = .Default
//        manager.shouldResignOnTouchOutside = true
//        manager.keyboardDistanceFromTextField = 5.0
    }
}
