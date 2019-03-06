//
//  XBBTwoBottomButtonView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/30.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

enum ButtonViewType {
    case `default`
    case waite
    case finish
}

protocol XBBTwoBottomButtonViewDelegate: NSObjectProtocol {
    func xbb_clickLeftButton(button: UIButton)
    func xbb_clickRightButton(button: UIButton)
}

class XBBTwoBottomButtonView: UIView {
    
    weak var delegate: XBBTwoBottomButtonViewDelegate?
    
    lazy var leftButton: UIButton = {
        let button = UIButton(title: "拒绝保全", titleColor: kTextColor6, bgColor: UIColor.white)
        button.addTarget(self, action: #selector(xbb_clickLeftButton(_:)), for: .touchUpInside)
        
        return button
    }()
    
    lazy var rightButton: UIButton = {
        let button = UIButton(title: "立即保全", titleColor: UIColor.white, bgColor: kThemeColor)
        button.addTarget(self, action: #selector(xbb_clickRightButton(_:)), for: .touchUpInside)
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

extension XBBTwoBottomButtonView {
    func xbb_setupView() {
        self.isHidden = true
        self.backgroundColor = UIColor.white
        
        addSubview(self.leftButton)
        self.leftButton.snp.makeConstraints { (make) in
            make.left.top.bottom.equalTo(0)
            make.width.equalTo(kScreenWidth / 2)
        }
        
        addSubview(self.rightButton)
        self.rightButton.snp.makeConstraints { (make) in
            make.right.top.bottom.equalTo(0)
            make.width.equalTo(kScreenWidth / 2)
        }
    }
    
    @objc func xbb_clickLeftButton(_ button: UIButton) {
        self.delegate?.xbb_clickLeftButton(button: button)
    }
    
    @objc func xbb_clickRightButton(_ button: UIButton) {
        self.delegate?.xbb_clickRightButton(button: button)
    }
    
    func setButtonTitle(type: ButtonViewType) {
        switch type {
        case .waite:
            self.isHidden = false
            self.leftButton.setTitle("拒绝签署", for: .normal)
            self.rightButton.setTitle("立即签署", for: .normal)
        case .finish:
            self.isHidden = false
            self.leftButton.setTitle("立即下载", for: .normal)
            self.rightButton.setTitle("申请出证", for: .normal)
        case .default:
            self.isHidden = false
        }
    }
}
