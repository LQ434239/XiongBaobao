//
//  XBBCourseTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/12.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBCourseTableViewCell: UITableViewCell {

    private lazy var thumbImgV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor3
        label.font = FontSize(14)
        label.numberOfLines = 2
        return label
    }()
    
    private lazy var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor9
        label.font = FontSize(10)
        return label
    }()
    
    var model: CourseModel? {
        didSet {
            self.thumbImgV.kf.setImage(with: URL(string: (model?.frontCoverPath)!), placeholder: UIImage(named:"default_image"))
            self.titleLabel.text = model?.title
            self.timeLabel.text = model?.createTime
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

extension XBBCourseTableViewCell {
    
    func xbb_setupView() {
        self.contentView.addSubview(self.thumbImgV)
        self.thumbImgV.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 95, height: 85))
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImgV.snp_rightMargin).offset(20)
            make.top.equalTo(self.thumbImgV.snp_topMargin).offset(-5)
            make.right.equalTo(-20)
        }
        
        self.contentView.addSubview(self.timeLabel)
        self.timeLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.thumbImgV.snp_rightMargin).offset(20)
            make.bottom.equalTo(self.thumbImgV.snp_bottomMargin).offset(5)
        }
    }
}

