//
//  XBBSignContractToolView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/6.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

protocol XBBSignContractToolViewDelegate: NSObjectProtocol {
    func xbb_clickSign(button: UIButton)
    func xbb_clickBook(button: UIButton)
    func xbb_clickSeal(button: UIButton)
    func xbb_clickNext(button: UIButton)
}

class XBBSignContractToolView: UIView {
    
    var isProxyC: Bool = false  { //是否是代理合同
        didSet {
            if !isProxyC {
                self.sealButton.isHidden = true
                
                let width = kScreenWidth / 3
                self.nextView.snp.updateConstraints { (make) in
                    make.width.equalTo(width)
                }
                self.signButton.snp.updateConstraints { (make) in
                    make.width.equalTo(width)
                }
                self.bookButton.snp.updateConstraints { (make) in
                    make.width.left.equalTo(width)
                }
            }
        }
    }
    
    weak var delegate: XBBSignContractToolViewDelegate?
    
    private lazy var signButton: UIButton = {
        let button = xbb_createButton(title: "手写签名", image: UIImage(named: "home_tab_nor")!, tag: 100)
        return button
    }()
    
    private lazy var bookButton: UIButton = {
        let button = xbb_createButton(title: "授权书", image: UIImage(named: "home_tab_nor")!, tag: 200)
        return button
    }()
    
    private lazy var sealButton: UIButton = {
        let button = xbb_createButton(title: "盖章", image: UIImage(named: "home_tab_nor")!, tag: 300)
        return button
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 400
        button.backgroundColor = kThemeColor
        button.titleLabel?.font = FontSize(14)
        button.setTitle("下一步", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(xbb_clickButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var nextView: UIView = {
        let view = UIView()
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xbb_setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.signButton.layoutButtonWithEdgeInsetsStyle(style: .bottom, space: 5)
        self.bookButton.layoutButtonWithEdgeInsetsStyle(style: .bottom, space: 5)
        self.sealButton.layoutButtonWithEdgeInsetsStyle(style: .bottom, space: 5)
    }
}

extension XBBSignContractToolView {
    
    private func xbb_createButton(title: String, image: UIImage, tag: Int) -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = tag
        button.titleLabel?.font = FontSize(10)
        button.setTitle(title, for: .normal)
        button.setTitleColor(kTextColor3, for: .normal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(xbb_clickButton(button:)), for: .touchUpInside)
        return button
    }
    
    func xbb_setupView() {
        
        self.backgroundColor = kBackgroundColor
        
        let width = kScreenWidth / 4
        
        addSubview(self.nextView)
        self.nextView.snp.makeConstraints { (make) in
            make.top.right.bottom.equalTo(0)
            make.width.equalTo(width)
        }
        
        self.nextView.addSubview(self.nextButton)
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
        
        addSubview(self.sealButton)
        self.sealButton.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.width.equalTo(width)
            make.left.equalTo(width * 2)
        }
    }
}

extension XBBSignContractToolView {
    @objc func xbb_clickButton(button: UIButton) {
        if button.tag == 100 { self.delegate?.xbb_clickSign(button: button) }
        if button.tag == 200 { self.delegate?.xbb_clickBook(button: button) }
        if button.tag == 300 { self.delegate?.xbb_clickSeal(button: button) }
        if button.tag == 400 { self.delegate?.xbb_clickNext(button: button) }
    }
}

