//
//  XBBTabBar.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBTabBar: UITabBar {

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        self.shadowImage = UIImage()
        self.backgroundImage = UIImage()
        self.shadow(offsetY: -2)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        for tabBarButton in self.subviews {
            if tabBarButton.isKind(of: NSClassFromString("UITabBarButton")!) {
              let button = tabBarButton as! UIControl
                button.addTarget(self, action: #selector(xbb_tabBarButtonClick(tabBarButton:)), for: .touchUpInside)
            }
        }
    }
    
    @objc func xbb_tabBarButtonClick(tabBarButton: UIControl) {
        for imageView in tabBarButton.subviews {
            if imageView.isKind(of: NSClassFromString("UITabBarSwappableImageView")!) {
                let animation = CAKeyframeAnimation.init(keyPath: "transform.scale")
                animation.values = [1.0, 1.1, 1.2, 1.1, 1.0]
                animation.duration = 0.5
                animation.calculationMode = CAAnimationCalculationMode.cubic
                imageView.layer.add(animation, forKey: nil)
            }
        }
    }
}
