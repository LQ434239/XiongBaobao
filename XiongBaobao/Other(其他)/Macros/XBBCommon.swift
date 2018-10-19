//
//  XBBCommon.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

/** 第三方应用 */
// Bugly
let kBuglyAppID  = "6ee1efe4bc"
let kBuglyAppKey = "faaf1d48-fa8a-4bcd-a8b0-a44179963a73"
//微信
let kWeiXinAppID = "wx49bd773c69118fed"
//极光
let kJPushAppKey = "164dd140c33b4c52cd192624"

let kDelegateWindow = UIApplication.shared.delegate?.window

let kUUID           = UUID().uuidString
let kVersion        = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

let kLineSize       = 1.0 / UIScreen.main.scale

//weak var weakSelf = self

let kMainBounds   = UIScreen.main.bounds
let KScreenWidth  = kMainBounds.size.width
let KScreenHeight = kMainBounds.size.height

// 判断是否为 iPhone X
let isIphoneX = KScreenHeight >= 812 ? true : false
// 导航栏
let kStatuHeight: CGFloat     = isIphoneX ? 44 : 20
let kTopSafeSpace: CGFloat    = isIphoneX ? 24 : 0
let kNavHeight: CGFloat       = 64 + kTopSafeSpace
// TabBar
let kBottomSafeSpace: CGFloat = isIphoneX ? 34 : 0
let kTabBarHeight: CGFloat    = 49 + kBottomSafeSpace

// MARK: 适配屏幕（iphone 6）
// 宽度比
let kWidthRatio  = KScreenWidth / 375.0
// 高度比
let kHeightRatio = KScreenHeight / 667.0

// 自适应
func Adaptation(_ value : CGFloat) -> CGFloat {
    return AdaptationWidth(value)
}

// 自适应宽度
func AdaptationWidth(_ value : CGFloat) -> CGFloat {
    return ceil(value) * kWidthRatio
}

// 自适应高度
func AdaptationHeight(_ value : CGFloat) -> CGFloat {
    return ceil(value) * kHeightRatio
}

// MARK: 字体
// 常规字体
func FontSize(_ size : CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: AdaptationWidth(size))
}

// 加粗字体
func BoldFontSize(_ size : CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: AdaptationWidth(size))
}


