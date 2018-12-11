//
//  UIColor+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/12.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

extension UIColor {
    // 实例方法创建,便利构造函数: 1.必须使用 convenience 2.在构造函数中必须使用一个设计的构造函数self
    convenience init(hex valueStr: String) {
        let scanner:Scanner = Scanner(string: valueStr)
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
