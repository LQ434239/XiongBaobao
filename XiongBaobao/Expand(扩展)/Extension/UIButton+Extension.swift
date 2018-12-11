//
//  UIButton+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/15.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

enum ButtonEdgeInsetsStyle {
    case top
    case left
    case bottom
    case right
}

extension UIButton {
    func layoutButtonWithEdgeInsetsStyle(style: ButtonEdgeInsetsStyle, space: CGFloat) {
        let imageWith = (self.imageView?.width)!
        let imageHeight = (self.imageView?.height)!
        let titleWidth = (self.titleLabel?.intrinsicContentSize.width)!
        let titleHight = (self.titleLabel?.intrinsicContentSize.height)!
        
        let margin = space/2.0
        
        var titleInsets: UIEdgeInsets
        var imageInsets: UIEdgeInsets
        
        switch (style) {
        case .top:
            titleInsets = UIEdgeInsets(top: -imageHeight-margin, left: -imageWith, bottom: 0, right: 0)
            imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: -titleHight-margin, right: -titleWidth)
        case .left:
            titleInsets = UIEdgeInsets(top: 0, left: -imageWith-margin, bottom: 0, right: imageWith+margin)
            imageInsets = UIEdgeInsets(top: 0, left: titleWidth+margin, bottom: 0, right: -titleWidth-margin)
        case .bottom:
            titleInsets = UIEdgeInsets(top: 0, left: -imageWith, bottom: -imageHeight-margin, right: 0)
            imageInsets = UIEdgeInsets(top: -titleHight-margin, left: 0, bottom: 0, right: -titleWidth)
        case .right:
            titleInsets = UIEdgeInsets(top: 0, left: margin, bottom: 0, right: -margin)
            imageInsets = UIEdgeInsets(top: 0, left: -margin, bottom: 0, right: margin)
        }
        self.titleEdgeInsets = titleInsets
        self.imageEdgeInsets = imageInsets
    }
    
    // MARK: 倒计时
    func countDown(count: Int) {
        // 倒计时开始,禁止点击事件
        self.isEnabled = false
        var remainingCount: Int = count {
            willSet {
                setTitle("\(newValue)s", for: .normal)
                if newValue <= 0 {
                    setTitle("获取验证码", for: .normal)
                }
            }
        }
        // 在global线程里创建一个时间源
        let codeTimer = DispatchSource.makeTimerSource(queue:DispatchQueue.global())
        // 设定时间源是每秒循环一次，立即开始
        codeTimer.schedule(deadline: .now(), repeating: .seconds(1))
        // 设定时间源的触发事件
        codeTimer.setEventHandler(handler: {
            // 返回主线程处理一些事件，更新UI等等
            DispatchQueue.main.async {
                // 每秒计时一次
                remainingCount -= 1
                // 时间到了取消时间源
                if remainingCount <= 0 {
                    self.isEnabled = true
                    codeTimer.cancel()
                }
            }
        })
        // 启动时间
        codeTimer.resume()
    }
}
