//
//  ShootButton.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

protocol ShootButtonDelegate: NSObjectProtocol {
    func shootStart(button: ShootButton, progress: CGFloat)
    func shootEnd(button: ShootButton)
}

class ShootButton: UIView {
    
    weak var delegate: ShootButtonDelegate?
    
    var progress: CGFloat = 0
    
    private lazy var centerButton: ShootCenterButton = {
        let button = ShootCenterButton()
        button.delegate = self
        return button
    }()
    
    var progressLayer = CAShapeLayer()
    var displayLink = CADisplayLink()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(self.centerButton)
        self.centerButton.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 7, left: 7, bottom: 7, right: 7))
        }
        self.progressLayer.strokeColor = kThemeColor.cgColor
        self.progressLayer.fillColor = UIColor.clear.cgColor
        self.progressLayer.lineWidth = 5
        self.progressLayer.strokeStart = 0
        self.progressLayer.strokeEnd = 0
        
        self.progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        self.layer.addSublayer(self.progressLayer)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        self.progressLayer.frame = self.bounds
        self.progressLayer.path = UIBezierPath(ovalIn: self.bounds).cgPath
    }
}

extension ShootButton: ShootCenterButtonDelegate {
    
    func shootStart(button: ShootCenterButton) {
        self.progressLayer.strokeColor = kThemeColor.cgColor
        self.displayLink = CADisplayLink(target: self, selector: #selector(changeProgerss))
        self.displayLink.add(to: RunLoop.current, forMode: .common)
        self.delegate?.shootStart(button: self, progress: self.progress)
    }
    
    func shootEnd(button: ShootCenterButton) {
        stopProress()
        self.delegate?.shootEnd(button: self)
    }
    
    @objc func changeProgerss() {
        let speed: CGFloat = (1.0/10.0)/60.0
        self.progress = self.progress + speed
        self.progressLayer.strokeEnd = self.progress
        if self.progress >= 1.0 {
            stopProress()
        }
        self.delegate?.shootStart(button: self, progress: self.progress)
    }
    
    func stopProress() {
        self.progress = 0
        self.progressLayer.strokeEnd = self.progress
        self.progressLayer.strokeColor = UIColor.clear.cgColor
        self.displayLink.invalidate()
    }
}
