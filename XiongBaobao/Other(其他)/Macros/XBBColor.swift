//
//  XBBColor.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

// 颜色
let kThemeColor: UIColor = UIColor(hex: "5f84ff")
let kLineColor : UIColor = UIColor(hex: "f2f2f2")
let kTextColor3: UIColor = UIColor(hex: "333333")
let kTextColor6: UIColor = UIColor(hex: "666666")
let kTextColor9: UIColor = UIColor(hex: "999999")
let kBackgroundColor: UIColor = UIColor(hex: "fbfbfb")


//取色
func colorValue(_ value: CGFloat) -> CGFloat {
    return value / 255.0
}

//随机色
func randomColor() -> UIColor {
    let red = (CGFloat)(arc4random() % 256)
    let green = (CGFloat)(arc4random() % 256)
    let blue = (CGFloat)(arc4random() % 256)
    return colorWithRGBA(red, green, blue, 1.0)
}

func colorWithRGBA(_ red: CGFloat,_ green: CGFloat , _ blue: CGFloat, _ alpha: CGFloat) -> UIColor {
    return UIColor(red: colorValue(red), green: colorValue(green), blue: colorValue(blue), alpha: alpha)
}

func withRGB(_ red: CGFloat, _ green: CGFloat, _ blue: CGFloat) -> UIColor {
    return colorWithRGBA(red, green, blue, 1)
}

