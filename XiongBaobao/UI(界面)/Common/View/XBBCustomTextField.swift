//
//  XBBCustomTextField.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/5.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

enum TextType {
    case code
    case phone
    case password
}

class XBBCustomTextField: UITextField {

    var maxLength: Int = 0
    
    var placeholderStr: String? {
        didSet {
            self.attributedPlaceholder = NSAttributedString.init(string: placeholderStr!, attributes: [.foregroundColor:kTextColor9, .font: FontSize(14)])
        }
    }
    
    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(kLineColor.cgColor)
        context!.fill(CGRect(x: 0, y: self.height - kLineSize, width: self.width, height: kLineSize))
    }
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.delegate = self
        self.font = FontSize(14)
        self.tintColor = kTextColor9
        self.textColor = kTextColor3
        self.backgroundColor = UIColor.white
        self.clearButtonMode = .whileEditing
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XBBCustomTextField {
    func setLeft(image: UIImage) {
        let leftView = UIImageView(image: image)
        leftView.contentMode = .center
        leftView.bounds = CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height)
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    func setLeft(text: String) {
        let label = UILabel()
        label.text = text
        label.textColor = kTextColor3
        label.font = FontSize(14)
        label.textAlignment = .center
        label.bounds = CGRect(x: 0, y: 0, width: 80, height: 30)
        self.leftView = label
        self.leftViewMode = .always
    }
    
    func setText(type: TextType) {
        switch type {
        case .code:
            self.keyboardType = .numberPad
        case .phone:
            self.keyboardType = .numberPad
        case .password:
            self.keyboardType = .asciiCapable
            self.isSecureTextEntry = true
        }
    }
}

extension XBBCustomTextField: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        //不允许输入空格
        let tem = string.components(separatedBy: CharacterSet.whitespaces).joined(separator: "")
        if string != tem {
            return false
        }
        
        //限制输入字数
        return self.maxLength > 0 ? (range.location < self.maxLength): true
    }
}
