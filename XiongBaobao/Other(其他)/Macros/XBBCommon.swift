//
//  Common.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit
import SnapKit

@_exported import Moya
@_exported import ObjectMapper
@_exported import RxCocoa
@_exported import RxSwift


// MARK: log日志
func NSLog<T>( _ message: T, file: String = #file, method: String = #function, line: Int = #line){
    #if DEBUG
    print("\((file as NSString).lastPathComponent)[\(line)], \(method): \(message)")
    #endif
}

/** 第三方应用 */
// Bugly
let kBuglyAppID  = "6ee1efe4bc"
let kBuglyAppKey = "faaf1d48-fa8a-4bcd-a8b0-a44179963a73"
//微信
let kWeiXinAppID = "wx49bd773c69118fed"
//极光
let kJPushAppKey = "164dd140c33b4c52cd192624"

let keyWindow = UIApplication.shared.keyWindow
let kAppdelegate = UIApplication.shared.delegate as! AppDelegate
let kDelegateWindow = kAppdelegate.window

//时间戳
let kTimeStamp = String(Int(Date().timeIntervalSince1970))

let kUUID           = UUID().uuidString
let kVersion        = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String

let kLineSize: CGFloat       = 1.0 
//let kLineSize       = 1.0 / UIScreen.main.scale

let kMainBounds   = UIScreen.main.bounds
let kScreenWidth  = kMainBounds.size.width
let kScreenHeight = kMainBounds.size.height

// 判断是否为 iPhone X
let isIphoneX = kScreenHeight >= 812 ? true: false
// 导航栏
let kStatuHeight: CGFloat     = isIphoneX ? 44: 20
let kTopSafeSpace: CGFloat    = isIphoneX ? 24: 0
let kNavHeight: CGFloat       = 64 + kTopSafeSpace
// TabBar
let kBottomSafeSpace: CGFloat = isIphoneX ? 34: 0
let kTabBarHeight: CGFloat    = 49 + kBottomSafeSpace

//分页控制器
let kPageMenuHeight: CGFloat = 45.0

var isProxyC: Bool = false //是否是代理合同

// MARK: 适配屏幕（iphone 6）
// 宽度比
let kWidthRatio  = kScreenWidth / 375.0
// 高度比
let kHeightRatio = kScreenHeight / 667.0

// 自适应宽度
func CGRatioWidth(_ value: CGFloat) -> CGFloat {
    return ceil(value) * kWidthRatio
}

// 自适应高度
func CGRatioHeight(_ value: CGFloat) -> CGFloat {
    return ceil(value) * kHeightRatio
}

// MARK: 字体
// 常规字体
func FontSize(_ size: CGFloat) -> UIFont {
    return UIFont.systemFont(ofSize: size)
}

// 加粗字体
func BoldFontSize(_ size: CGFloat) -> UIFont {
    return UIFont.boldSystemFont(ofSize: size)
}


