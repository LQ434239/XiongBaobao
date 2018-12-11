//
//  ShootCenterButton.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

protocol ShootCenterButtonDelegate {
    func shootStart(button: ShootCenterButton)
    func shootEnd(button: ShootCenterButton)
}

class ShootCenterButton: UIView {
    
    var delegate: ShootCenterButtonDelegate?
    
    var path = UIBezierPath()
    var centerLayer = CAShapeLayer()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.centerLayer.frame = self.bounds
        //设置绘制路径
        self.centerLayer.path = UIBezierPath(ovalIn: self.bounds).cgPath
    }
}

extension ShootCenterButton {
    func setupView() {
        self.centerLayer.frame = self.bounds
        self.centerLayer.path = self.path.cgPath
        self.centerLayer.strokeColor = UIColor(hex: "dad9d6").cgColor
        self.centerLayer.fillColor = kThemeColor.cgColor
        self.centerLayer.lineWidth = 15
        //设置轮廓结束位置
        self.centerLayer.strokeEnd = 1
        self.layer.addSublayer(self.centerLayer)
        
        let gesture = UILongPressGestureRecognizer(target: self, action: #selector(longPress(gesture:)))
        self.isUserInteractionEnabled = true
        addGestureRecognizer(gesture)
    }
    
    @objc func longPress(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            self.centerLayer.lineWidth = 18
            self.delegate?.shootStart(button: self)
        }
        
        if gesture.state == .ended {
            self.centerLayer.lineWidth = 10
            self.delegate?.shootEnd(button: self)
        }
    }
}
