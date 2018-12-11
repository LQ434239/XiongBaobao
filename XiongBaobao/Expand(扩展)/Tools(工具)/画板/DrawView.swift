//
//  DrawView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/8.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class DrawView: UIView {
    
    var isDraw: Bool = false
    
    var paths: [DrawiPath] = []
    var path: DrawiPath?
    var lineWidth: CGFloat = 8
    var lineColor: UIColor = kTextColor3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(gesture:)))
        addGestureRecognizer(panGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func draw(_ rect: CGRect) {
        for path in self.paths {
            path.color?.set()
            path.stroke()
        }
    }
}

extension DrawView {
    
    @objc func panAction(gesture: UIPanGestureRecognizer) {
        let currentPoint: CGPoint = gesture.location(in: self)
        if gesture.state == .began {
            let path = DrawiPath()
            self.path = path
            self.paths.append(path)
            
            path.color = self.lineColor
            
            self.path?.lineWidth = self.lineWidth
            
            self.path?.move(to: currentPoint)
        } else if gesture.state == .changed {
            self.path?.addLine(to: currentPoint)
            setNeedsDisplay()
        }
        
        self.isDraw = true
    }
    
    //清屏
    func clearScreen() {
        self.paths.removeAll()
        setNeedsDisplay()
        self.isDraw = false
    }
    
    //撤销
    func revoke() {
        self.paths.removeLast()
        setNeedsDisplay()
    }
    
    //橡皮擦
    func erease() {
        self.lineColor = UIColor.white
    }
    
    //设置颜色
    func setPenColor(color: UIColor) {
        self.lineColor = color
        setNeedsDisplay()
    }
    
    //设置线条宽度
    func setPenWidth(width: CGFloat) {
        self.lineWidth = width
        setNeedsDisplay()
    }
}
