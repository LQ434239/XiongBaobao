//
//  UpdateAlert.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/8.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

private let defaultMaxHeight = kScreenHeight*2/3
private let itunesUrl = "http://itunes.apple.com/us/app/id1314302093"

class UpdateAlert: UIView {
    var version: String = "" {
        didSet {
            self.versionLabel.text = "V\(version)"
        }
    }
    
    var content: String = "" {
        didSet {
            self.textView.text = content
        }
    }
    
    private lazy var updateView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.corner(radius: 12)
        return view
    }()
    
    private lazy var updateIcon: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: ""))
        return imgV
    }()
    
    private lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.font = FontSize(18)
        label.textAlignment = .center
        label.textColor = kTextColor3
        return label
    }()
    
    private lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = FontSize(14)
        textView.textContainer.lineFragmentPadding = 0
        textView.textColor = kTextColor3
        textView.isEditable = false
        textView.isSelectable = false
        textView.showsVerticalScrollIndicator = false
        textView.showsHorizontalScrollIndicator = false
        return textView
    }()
    
    private lazy var updateButton: UIButton = {
        let button = UIButton(title: "立即更新", titleColor: UIColor.white, bgColor: kThemeColor)
        button.addTarget(self, action: #selector(clickUpdateButton), for: .touchUpInside)
        button.corner(radius: 2)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton(title: "取消更新", titleColor: kTextColor6, bgColor: UIColor.white)
        button.addTarget(self, action: #selector(clickCancelButton), for: .touchUpInside)
        button.corner(radius: 2, color: kTextColor6, width: kLineSize)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension UpdateAlert {
    func setupView() {
        self.frame = kMainBounds
        self.backgroundColor = colorWithRGBA(0, 0, 0, 0.3)
        
        //获取更新内容高度
        var contentHeight = self.version.heigthForFont(font: FontSize(16), width: kScreenWidth - CGRatioWidth(100))
        //实际高度
        let realHeight = contentHeight + CGRatioHeight(270)
        //最大高度
        var maxHeight = defaultMaxHeight
        
        //重置updateView最大高度
        if realHeight > defaultMaxHeight {
            contentHeight = defaultMaxHeight - CGRatioHeight(270)
        } else {
            maxHeight = realHeight
        }
        
        addSubview(self.updateView)
        self.updateView.snp.makeConstraints { (make) in
            make.center.equalTo(self)
            make.size.equalTo(CGSize(width: kScreenWidth - CGRatioWidth(80), height: maxHeight))
        }
        
        self.updateView.addSubview(self.updateIcon)
        self.updateIcon.snp.makeConstraints { (make) in
            make.top.left.right.equalTo(0)
            make.height.equalTo(CGRatioHeight(150))
        }
        
        self.updateView.addSubview(self.versionLabel)
        self.versionLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.updateIcon.snp.bottom).offset(CGRatioHeight(15))
            make.centerX.equalTo(self)
        }
        
        self.updateView.addSubview(self.updateButton)
        self.updateButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.updateView.snp.centerX).offset(CGRatioWidth(10))
            make.right.equalTo(CGRatioWidth(-25))
            make.bottom.equalTo(CGRatioWidth(-15))
            make.height.equalTo(35)
        }
        
        self.updateView.addSubview(self.cancelButton)
        self.cancelButton.snp.makeConstraints { (make) in
            make.left.equalTo(CGRatioWidth(25))
            make.right.equalTo(self.updateView.snp.centerX).offset(CGRatioWidth(-10))
            make.bottom.equalTo(CGRatioHeight(-15))
            make.height.equalTo(35)
        }
        
        self.updateButton.addSubview(self.textView)
        self.textView.snp.makeConstraints { (make) in
            make.top.equalTo(self.versionLabel.snp.bottom).offset(CGRatioHeight(15))
            make.left.equalTo(CGRatioWidth(20))
            make.right.equalTo(CGRatioWidth(-20))
            make.bottom.equalTo(self.cancelButton.snp.top).offset(CGRatioHeight(-15))
        }
        
        self.updateView.showZoomAnimation()
    }
    
    // MARK: Event
    @objc func clickUpdateButton() {
        UIApplication.shared.open(URL(string: itunesUrl)!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: true], completionHandler: nil)
    }
    
    @objc func clickCancelButton() {
        UIView.animate(withDuration: 0.5, animations: {
            self.transform = CGAffineTransform(scaleX: 0.5, y: 0.5)
            self.backgroundColor = UIColor.clear
            self.alpha = 0
        }) { (finished) in
            self.removeFromSuperview()
        }
    }
}
