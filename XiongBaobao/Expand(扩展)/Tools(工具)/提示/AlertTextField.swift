//
//  AlertTextField.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/2.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class AlertTextField: UIView {

    private lazy var bgView: UIView = {
        var view = UIView()
        view.backgroundColor = UIColor.white
        view.corner(radius: 2)
        return view
    }()
    
    private lazy var titleLabel: UILabel = {
        var label = UILabel()
        label.textColor = kTextColor3
        label.font = FontSize(18)
        label.text = "修改昵称"
        return label
    }()
    
    private lazy var textField: UITextField = {
        var textField = UITextField()
        return textField
    }()
    
    private lazy var cancelButton: UIButton = {
        var button = UIButton(title: "取消", titleColor: kTextColor9, bgColor: UIColor.white)
        button.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return button
    }()
    
    private lazy var sureButton: UIButton = {
        var button = UIButton(title: "确定", titleColor: kTextColor9, bgColor: UIColor.white)
        button.addTarget(self, action: #selector(sureAction), for: .touchUpInside)
        return button
    }()
}

extension AlertTextField {
    @objc func dismiss() {
        
    }
    
    @objc func sureAction() {
        
    }
}
