//
//  XBBPreserveTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/14.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBPreserveTableViewCell: XBBLineTableViewCell {
    
    private lazy var thumbImgV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor3
        label.font = FontSize(14)
        return label
    }()
    
    private lazy var sizeLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor9
        label.font = FontSize(12)
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor9
        label.font = FontSize(12)
        return label
    }()
    
    var model: PreserveModel? {
        didSet {
            self.thumbImgV.kf.setImage(with: URL(string: (model?.thumbnail)!), placeholder: UIImage(named:"default_image"))
            self.titleLabel.text = model?.fileName
            self.sizeLabel.text = String(format: "%.2fM", (model?.fileSize)! / 1024 / 1024)
            self.timeLabel.text = String((model?.createDate?.prefix(10))!)
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

extension XBBPreserveTableViewCell {
    
    func xbb_setupView() {
        self.accessoryType = .none
        self.contentView.addSubview(self.thumbImgV)
        self.thumbImgV.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImgV.snp_rightMargin).offset(20)
            make.top.equalTo(self.thumbImgV.snp_topMargin).offset(-7)
            make.right.equalTo(-12)
        }
        
        self.contentView.addSubview(self.sizeLabel)
        self.sizeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImgV.snp_rightMargin).offset(20)
            make.bottom.equalTo(self.thumbImgV.snp_bottomMargin).offset(7)
        }
        
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.centerY.equalTo(self.sizeLabel)
        }
    }
}
