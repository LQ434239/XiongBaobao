//
//  XBBConfigurationManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

class ConfigurationManager: NSObject {
    
   static func setLaunchOption() {
        self.xbb_initBaseSetup()
        self.xbb_setIQKeyboardManager()
    }
    
   private static func xbb_initBaseSetup() {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
            UICollectionView.appearance().contentInsetAdjustmentBehavior = .automatic
            
            UITableView.appearance().estimatedRowHeight = 0;
            UITableView.appearance().estimatedSectionHeaderHeight = 0;
            UITableView.appearance().estimatedSectionFooterHeight = 0;
        }
        UIButton.appearance().isExclusiveTouch = false
    }
    
    private static func xbb_setIQKeyboardManager() {
        let manager = IQKeyboardManager.shared
        manager.enableAutoToolbar = false
        manager.previousNextDisplayMode = .Default
        manager.shouldResignOnTouchOutside = true
        manager.keyboardDistanceFromTextField = 5.0
    }
}
