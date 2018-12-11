//
//  UIView+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

enum UIBorderSideType {
    case UIBorderSideTypeAll
    case UIBorderSideTypeTop
    case UIBorderSideTypeBottom
    case UIBorderSideTypeLeft
    case UIBorderSideTypeRight
}

extension UIView {
//    public var left: CGFloat {
//        get {
//            return self.frame.origin.x
//        }
//        set(newLeft) {
//            var frame = self.frame
//            frame.origin.x = newLeft
//            self.frame = frame
//        }
//    }
//    
//    public var top:CGFloat {
//        get {
//            return self.frame.origin.y
//        }
//        set {
//            var frame = self.frame
//            frame.origin.y = newValue
//            self.frame = frame
//        }
//    }
//    
//    public var right: CGFloat {
//        get {
//            return self.left + self.width
//        }
//    }
//    
//    public var bottom:CGFloat {
//        get {
//            return self.top + self.height
//        }
//    }
//    
//    public var centerX: CGFloat {
//        get {
//            return self.center.x
//        }
//        set {
//            self.center = CGPoint(x: newValue, y: self.center.y)
//        }
//    }
//    public var centerY: CGFloat {
//        get {
//            return self.center.y
//        }
//        set {
//            self.center = CGPoint(x: self.center.x, y: newValue)
//        }
//    }
//    public var width: CGFloat {
//        get {
//            return self.frame.size.width
//        }
//        set {
//            var frame = self.frame
//            frame.size.width = newValue
//            self.frame = frame
//        }
//    }
//    public var height: CGFloat {
//        get {
//            return self.frame.size.height
//        }
//        set {
//            var frame = self.frame
//            frame.size.height = newValue
//            self.frame = frame
//        }
//    }
//    public var origin: CGPoint {
//        get {
//            return self.frame.origin
//        }
//        set {
//            self.left = newValue.x
//            self.top = newValue.y
//        }
//    }
//    public var size: CGSize {
//        get {
//            return self.frame.size
//        }
//        set {
//            self.width = newValue.width
//            self.height = newValue.height
//        }
//    }
    
    // MARK: 圆角
    func corner(radius: CGFloat) {
        self.corner(radius: radius, color: UIColor.clear, width: 1.0)
    }
  
    func corner(radius: CGFloat, color: UIColor) {
        self.corner(radius: radius, color: color, width: 1.0)
    }
    
    func corner(radius: CGFloat, color: UIColor, width:CGFloat) {
        if self.backgroundColor == nil {
            self.backgroundColor = .white
        }
        self.layer.masksToBounds = true
        self.layer.cornerRadius = radius
        self.layer.borderWidth = width
        self.layer.borderColor = color.cgColor
    }
    
    // MARK: 阴影
    func shadow(radius: CGFloat) {
        self.shadow(offsetX: 0, offsetY: 0, opacity: 0.3, radius: radius)
    }
    
    func shadow(radius: CGFloat, opacity: Float) {
        self.shadow(offsetX: 0, offsetY: 0, opacity: opacity, radius: radius)
    }
    
    func shadow(offsetX: CGFloat) {
        self.shadow(offsetX: offsetX, offsetY: 0, opacity: 0.3, radius: 5)
    }
    
    func shadow(offsetY: CGFloat) {
        self.shadow(offsetX: 0, offsetY: offsetY, opacity: 0.3, radius: 5)
    }
    
    func shadow(offsetX: CGFloat, offsetY: CGFloat, opacity: Float, radius: CGFloat) {
        self.layer.shadowColor = kTextColor9.cgColor
        //偏移距离
        self.layer.shadowOffset = CGSize(width: offsetX, height: offsetY)
        //不透明度
        self.layer.shadowOpacity = opacity
        //半径
        self.layer.shadowRadius = radius
        //设置成yes后没有阴影
        self.layer.masksToBounds = false
    }
    
    // MARK: 边框
    func border(color: UIColor, borderWidth:CGFloat, borderType:UIBorderSideType) {
        switch borderType {
        case .UIBorderSideTypeAll:
            self.layer.borderWidth = borderWidth
            self.layer.borderColor = color.cgColor
            break
            
        case .UIBorderSideTypeTop:
            self.layer.addSublayer(self.addLine(originPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: self.width, y: 0), color: color, borderWidth: borderWidth))
            break
        case .UIBorderSideTypeBottom:
            self.layer.addSublayer(self.addLine(originPoint: CGPoint(x: 0, y: self.height), toPoint: CGPoint(x: self.width, y: self.height), color: color, borderWidth: borderWidth))
            break
            
        case .UIBorderSideTypeLeft:
            self.layer.addSublayer(self.addLine(originPoint: CGPoint(x: 0, y: 0), toPoint: CGPoint(x: 0, y: self.height), color: color, borderWidth: borderWidth))
            break
            
        case .UIBorderSideTypeRight:
            self.layer.addSublayer(self.addLine(originPoint: CGPoint(x: self.width, y: 0), toPoint: CGPoint(x: self.width, y: self.height), color: color, borderWidth: borderWidth))
            break
        }
    }
    
    func addLine(originPoint: CGPoint, toPoint:CGPoint, color: UIColor, borderWidth:CGFloat) -> CAShapeLayer {
        let bezierPath = UIBezierPath()
        bezierPath.move(to: originPoint)
        bezierPath.addLine(to: toPoint)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.path = bezierPath.cgPath
        shapeLayer.lineWidth = borderWidth
        return shapeLayer
    }
    
    // MARK: 截图
    func snapshotImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, 0)
        let context = UIGraphicsGetCurrentContext()
        self.layer.render(in: context!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    // MARK: 缩放
    func showZoomAnimation() {
        let animation = CAKeyframeAnimation()
        animation.keyPath = "transform.scale"
        animation.values = [1.0, 1.1, 1.2, 1.1, 1.0]
        animation.duration = 0.5
        animation.calculationMode = .cubic
        self.layer.add(animation, forKey: nil)
    }
}

