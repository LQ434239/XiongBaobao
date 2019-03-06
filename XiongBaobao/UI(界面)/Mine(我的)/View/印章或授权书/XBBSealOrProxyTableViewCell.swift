//
//  XBBSealOrProxyTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/12.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import Kingfisher

class XBBSealOrProxyTableViewCell: UITableViewCell {

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
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor9
        label.font = FontSize(12)
        return label
    }()
    
    private lazy var selectImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "选中"))
        return imgV
    }()
    
    var sealModel: SealModel? {
        didSet {
            self.thumbImgV.kf.setImage(with: URL(string: (sealModel?.sealPath)!), placeholder: UIImage(named:"default_image"))
            self.titleLabel.text = sealModel?.sealName
            self.timeLabel.text = sealModel?.createTime
        }
    }
    
    var proxyModel: ProxyModel? {
        didSet {
            self.thumbImgV.kf.setImage(with: URL(string: (proxyModel?.certificatePath)!), placeholder: UIImage(named:"default_image"))
            self.titleLabel.text = proxyModel?.certificateName
            self.timeLabel.text = proxyModel?.createTime
        }
    }
    
    override var frame: CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.origin.y += 5
            newFrame.size.width -= 20
            newFrame.size.height -= 10
            super.frame = newFrame
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

extension XBBSealOrProxyTableViewCell {
    
    func xbb_setupView() {
        self.accessoryType = .none
        self.contentView.addSubview(self.thumbImgV)
        self.thumbImgV.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 45, height: 45))
        }
        
        self.contentView.addSubview(self.selectImgV)
        self.selectImgV.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.centerY.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImgV.snp_rightMargin).offset(20)
            make.top.equalTo(self.thumbImgV.snp_topMargin).offset(-10)
            make.right.equalTo(self.selectImgV.snp_leftMargin).offset(-20)
        }
        
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImgV.snp_rightMargin).offset(20)
            make.bottom.equalTo(self.thumbImgV.snp_bottomMargin).offset(10)
        }
    }
}
