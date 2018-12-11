//
//  NSString+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

enum CompareResult {
    case bigger
    case smaller
    case equal
}

extension String {
    
    //字符串的宽
    func widthForFont(font: UIFont) -> CGFloat {
        let width = self.size(withAttributes: [.font:font]).width
        return width
    }
    
    //字符串的高
    func heigthForFont(font: UIFont, width: CGFloat) -> CGFloat {
        return self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options:.usesLineFragmentOrigin, attributes: [.font:font], context:nil).height
    }
    
    /*
     *  判断用户输入的密码是否符合规范，符合规范的密码要求：
     1. 长度大于6位
     2. 密码中必须同时包含数字和字母
     */
    func judgePassWordLegal() -> Bool {
        let result: Bool = false
        if self.count >= 6 {
            let regex = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,16}$"
            let pred = NSPredicate(format: "SELF MATCHES %@" , regex)
            return (pred.evaluate(with: self))
        }
        return result
    }
    
    //手机
    func isPhoneNumber() -> Bool {
        let result: Bool = false
        if self.count == 11 {
            // 手机号以 13 14 15 18 开头 八个数字字符
            let phoneRegex = "^1[34578]\\d{9}$"
            let phoneTest = NSPredicate(format: "SELF MATCHES %@" , phoneRegex)
            return (phoneTest.evaluate(with: self))
        }
        return result
    }
    
    //比较版本
    func versionCompare() -> CompareResult {
        let currentVersionArray: [String] = self.components(separatedBy: ".")
        let oldVersionArray: [String] = kVersion.components(separatedBy: ".")
        for i in 0..<currentVersionArray.count {
            if Int(currentVersionArray[i])! != Int(oldVersionArray[i])! {
                if Int(currentVersionArray[i])! > Int(oldVersionArray[i])! {
                    return .bigger
                } else {
                    return .smaller
                }
            }
        }
        return .equal
    }
}


