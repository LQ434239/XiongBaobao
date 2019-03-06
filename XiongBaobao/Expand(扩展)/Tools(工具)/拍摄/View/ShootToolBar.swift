//
//  ShootToolBar.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

protocol ShootToolBarDelegate: NSObjectProtocol {
    func shootToolBarAction(index: NSInteger)
    func shootStart(button: ShootToolBar, progress: CGFloat)
    func shootEnd(button: ShootToolBar)
}

class ShootToolBar: UIView {
    
    weak var delegate: ShootToolBarDelegate?
    
    private lazy var shootButton: ShootButton = {
        let button = ShootButton()
        button.delegate = self
        return button
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 1
        button.setImage(UIImage(named: "camera_close"), for: .normal)
        button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var changeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 2
        button.setImage(UIImage(named: "camera_change"), for: .normal)
        button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var againButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 3
        button.isHidden = true
        button.setImage(UIImage(named: "camera_again"), for: .normal)
        button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var finishButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 4
        button.isHidden = true
        button.setImage(UIImage(named: "camera_finish"), for: .normal)
        button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xbb_setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ShootToolBar {
    func xbb_setupView() {
        
        addSubview(self.closeButton)
        addSubview(self.changeButton)
        addSubview(self.shootButton)
        addSubview(self.againButton)
        addSubview(self.finishButton)
        
        self.closeButton.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(kTopSafeSpace + 30)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        self.changeButton.snp.makeConstraints { (make) in
            make.right.equalTo(-10)
            make.top.equalTo(kTopSafeSpace + 30)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        self.shootButton.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.bottom.equalTo(-kBottomSafeSpace - CGRatioHeight(130))
            make.size.equalTo(CGSize(width: 80, height: 80))
        }
        
        self.againButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.shootButton)
            make.right.equalTo(self.shootButton.snp_leftMargin).offset(CGRatioWidth(-30))
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
        
        self.finishButton.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.shootButton)
            make.left.equalTo(self.shootButton.snp_rightMargin).offset(CGRatioWidth(30))
            make.size.equalTo(CGSize(width: 70, height: 70))
        }
    }
    
    @objc func clickButton(button: UIButton) {
        if button.tag == 3 {
            buttonAnimation(open: false)
        }
        self.delegate?.shootToolBarAction(index: button.tag)
    }
    
    func buttonAnimation(open: Bool) {
        self.closeButton.isHidden = open
        self.changeButton.isHidden = open
        self.shootButton.isHidden = open
        self.againButton.isHidden = !open
        self.finishButton.isHidden = !open
        if open {
            UIView.animate(withDuration: 0.5) {
                self.againButton.transform = CGAffineTransform(translationX: CGRatioWidth(-20), y: 0).concatenating(self.againButton.transform)
                self.finishButton.transform = CGAffineTransform(translationX: CGRatioWidth(20), y: 0).concatenating(self.finishButton.transform)
            }
            return
        }
        self.againButton.transform = CGAffineTransform.identity
        self.finishButton.transform = CGAffineTransform.identity
    }
}

extension ShootToolBar: ShootButtonDelegate {
    func shootStart(button: ShootButton, progress: CGFloat) {
        self.delegate?.shootStart(button: self, progress: progress)
    }
    
    func shootEnd(button: ShootButton) {
        buttonAnimation(open: true)
        button.isHidden = true
        self.delegate?.shootEnd(button: self)
    }
}
