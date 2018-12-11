//
//  XBBSignContractToolView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/6.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

protocol XBBSignContractToolViewDelegate {
    func clickSign(button: UIButton)
    func clickBook(button: UIButton)
    func clickSeal(button: UIButton)
    func clickNext(button: UIButton)
}

class XBBSignContractToolView: UIView {
    
    var delegate: XBBSignContractToolViewDelegate?
    
    private lazy var signButton: UIButton = {
        let button = createButton(title: "手写签名", image: UIImage(named: "home_tab_nor")!, tag: 100)
        return button
    }()
    
    private lazy var bookButton: UIButton = {
        let button = createButton(title: "授权书", image: UIImage(named: "home_tab_nor")!, tag: 200)
        return button
    }()
    
    private lazy var sealButton: UIButton = {
        let button = createButton(title: "盖章", image: UIImage(named: "home_tab_nor")!, tag: 300)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 400
        button.backgroundColor = kThemeColor
        button.titleLabel?.font = FontSize(14)
        button.setTitle("下一步", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createButton(title: String, image: UIImage, tag: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = tag
        button.titleLabel?.font = FontSize(10)
        button.setTitle(title, for: .normal)
        button.setTitleColor(kTextColor3, for: .normal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(clickButton(button:)), for: .touchUpInside)
        return button
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.signButton.layoutButtonWithEdgeInsetsStyle(style: .bottom, space: 5)
        self.bookButton.layoutButtonWithEdgeInsetsStyle(style: .bottom, space: 5)
        self.sealButton.layoutButtonWithEdgeInsetsStyle(style: .bottom, space: 5)
    }
}

extension XBBSignContractToolView {
    func setupView() {
        
        self.backgroundColor = kBackgroundColor
        
        var width = kScreenWidth / 3
        if isProxyC {
            width = kScreenWidth / 4
        }
        
        let view = UIView()
        addSubview(view)
        view.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(0)
            make.width.equalTo(width)
        }
        
        view.addSubview(self.nextButton)
        self.nextButton.snp.makeConstraints { (make) in
            make.top.equalTo(10)
            make.right.bottom.equalTo(-10)
            make.width.equalTo(kScreenWidth / 4 - 30)
        }
        self.nextButton.corner(radius: 5)
        
        addSubview(self.signButton)
        self.signButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.width.equalTo(width)
        }
        
        addSubview(self.bookButton)
        self.bookButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(self)
            make.width.left.equalTo(width)
        }
        
        if isProxyC {
            addSubview(self.sealButton)
            self.sealButton.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(0)
                make.width.equalTo(width)
                make.left.equalTo(width*2)
            }
        }
    }
}

extension XBBSignContractToolView {
    @objc func clickButton(button: UIButton) {
        if button.tag == 100 { self.delegate?.clickSign(button: button) }

        if button.tag == 200 { self.delegate?.clickBook(button: button) }
        
        if button.tag == 300 { self.delegate?.clickSeal(button: button) }
        
        if button.tag == 400 { self.delegate?.clickNext(button: button) }
    }
}

