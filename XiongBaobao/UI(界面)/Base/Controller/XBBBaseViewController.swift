//
//  XBBBaseViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBBaseViewController: UIViewController {

    private var leftButton: UIButton = {
        let button = UIButton(type: .custom)
        button.sizeToFit()
        button.titleLabel?.font = FontSize(16)
        button.setTitleColor(kTextColor6, for: .normal)
        return button
    }()
    
    private var rightButton: UIButton = {
        let button = UIButton(type: .custom)
        button.sizeToFit()
        button.titleLabel?.font = FontSize(16)
        button.setTitleColor(kTextColor6, for: .normal)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = kBackgroundColor
        
        self.automaticallyAdjustsScrollViewInsets = false
    }
}

extension XBBBaseViewController {
    @objc func clickLeftItem(_ button: UIButton) {}
    
    @objc func clickRightItem(_ button: UIButton) {}
}

extension XBBBaseViewController {
    
    func setLeftItem(title: String) {
        setLeftItem(title: title, image: nil, titleColor: kTextColor6)
    }
    
    func setLeftItem(image: UIImage) {
        setLeftItem(title: nil, image: image, titleColor: nil)
    }
    
    private func setLeftItem(title: String?, image: UIImage?, titleColor: UIColor?) {
        self.leftButton.setTitle(title, for: .normal)
        self.leftButton.setImage(image, for: .normal)
        self.leftButton.setTitleColor(titleColor, for: .normal)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem.init(customView: self.leftButton)
        self.leftButton.addTarget(self, action: #selector(clickLeftItem(_:)), for: .touchUpInside)
    }
    
    func setRightItem(title: String, titleColor: UIColor) {
        setRightItem(title: title, image: nil, titleColor: titleColor)
    }
    
    func setRightItem(image: UIImage) {
        setRightItem(title: nil, image: image, titleColor: nil)
    }
    
    private func setRightItem(title: String?, image: UIImage?, titleColor: UIColor?) {
        self.rightButton.setTitle(title, for: .normal)
        self.rightButton.setImage(image, for: .normal)
        self.rightButton.setTitleColor(titleColor, for: .normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: self.rightButton)
        self.rightButton.addTarget(self, action: #selector(clickRightItem(_:)), for: .touchUpInside)
    }
}
