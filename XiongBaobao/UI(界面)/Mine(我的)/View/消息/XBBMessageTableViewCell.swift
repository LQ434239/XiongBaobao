//
//  XBBMessageTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/11.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBMessageTableViewCell: XBBLineTableViewCell {

    private lazy var thumbImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "default_image"))
        return imgV
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "消息"
        label.textColor = kTextColor3
        label.font = FontSize(16)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "2018-00-00"
        label.textColor = kTextColor6
        label.font = FontSize(14)
        return label
    }()
    
    private lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.text = "消息"
        label.textColor = kTextColor9
        label.font = FontSize(12)
        label.numberOfLines = 2
        return label
    }()
    
    var model: MessageModel? {
        didSet {
            self.titleLabel.text = model?.title
            self.timeLabel.text = model?.createTime
            self.contentLabel.text = model?.contentStr
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        xbb_setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XBBMessageTableViewCell {
    func xbb_setupView() {
        self.accessoryType = .disclosureIndicator
        
        self.contentView.addSubview(self.thumbImgV)
        self.thumbImgV.snp.makeConstraints { (make) in
            make.left.equalTo(15)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 40, height: 40))
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImgV.snp_rightMargin).offset(20)
            make.top.equalTo(self.thumbImgV.snp_topMargin).offset(-15)
        }
        
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.titleLabel.snp_rightMargin).offset(10)
            make.centerY.equalTo(self.titleLabel)
            make.right.equalTo(-10)
        }
        self.timeLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        self.contentView.addSubview(self.contentLabel)
        self.contentLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImgV.snp_rightMargin).offset(20)
            make.bottom.equalTo(self.thumbImgV.snp_bottomMargin)
            make.right.equalTo(-10)
            make.top.equalTo(self.thumbImgV.snp_centerYWithinMargins)
        }
    }
}
