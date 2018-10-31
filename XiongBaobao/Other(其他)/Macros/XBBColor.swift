//
//  XBBColor.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

let kWhite       = UIColor.white

// 颜色
let kThemeColor: UIColor = UIColor("5f84ff")
let kLineColor : UIColor = UIColor("f2f2f2")
let kTextColor3: UIColor = UIColor("333333")
let kTextColor6: UIColor = UIColor("666666")
let kTextColor9: UIColor = UIColor("999999")
let kBackgroundColor: UIColor = UIColor("ededed")

extension UIColor {
    // 实例方法创建,便利构造函数: 1.必须使用 convenience 2.在构造函数中必须使用一个设计的构造函数self
    convenience init(_ valueStr:String) {
        let scanner:Scanner = Scanner(string:valueStr)
        var valueRGB:UInt32 = 0
        if scanner.scanHexInt32(&valueRGB) == false {
            self.init(red: 0,green: 0,blue: 0,alpha: 0)
        } else {
            self.init(
                red:CGFloat((valueRGB & 0xFF0000)>>16)/255.0,
                green:CGFloat((valueRGB & 0x00FF00)>>8)/255.0,
                blue:CGFloat(valueRGB & 0x0000FF)/255.0,
                alpha:CGFloat(1.0)
            )
        }
    }
}

//取色
func colorValue(_ value : CGFloat) -> CGFloat {
    return value / 255.0
}

//随机色
func RandomColor() -> UIColor {
    let red = (CGFloat)(arc4random() % 256)
    let green = (CGFloat)(arc4random() % 256)
    let blue = (CGFloat)(arc4random() % 256)
    return colorWithRGBA(red, green, blue, 1.0)
}

// UIColor,通过 RGBA数值设置颜色
func colorWithRGBA(_ red : CGFloat,_ green : CGFloat , _ blue : CGFloat,_ alpha : CGFloat) -> UIColor {
    return UIColor(red: colorValue(red), green: colorValue(green), blue: colorValue(blue), alpha: alpha)
}

func withRGB(_ red:CGFloat, _ green:CGFloat, _ blue:CGFloat) -> UIColor {
    return colorWithRGBA(red, green, blue, 1)
}

