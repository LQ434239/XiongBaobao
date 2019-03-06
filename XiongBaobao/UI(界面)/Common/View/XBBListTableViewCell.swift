//
//  XBBListTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/12.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBListTableViewCell: XBBLineTableViewCell {

    private lazy var iconImgV: UIImageView = {
        let imgV = UIImageView()
        return imgV
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor3
        label.font = BoldFontSize(14)
        return label
    }()
    
    private lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor9
        label.font = FontSize(12)
        return label
    }()
    
    private lazy var rightImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "右箭头"))
        return imgV
    }()
    
    var layoutModel: XBBLayoutModel? {
        didSet {
            self.iconImgV.image = UIImage(named: (layoutModel?.icon!)!)
            self.titleLabel.text = layoutModel?.title
            self.subtitleLabel.text = layoutModel?.subtitle
            self.lineView.isHidden = layoutModel!.isHiddenLine
        }
    }
    
//    override var frame: CGRect {
//        didSet {
//            var newFrame = frame
//            newFrame.origin.x += 10
//            newFrame.origin.y += 5
//            newFrame.size.width -= 20
//            newFrame.size.height -= 10
//            super.frame = newFrame
//        }
//    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        xbb_setupView() 
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XBBListTableViewCell {
    
    func xbb_setupView() {
//        self.contentView.corner(radius: 5)
    
        self.contentView.addSubview(self.iconImgV)
        self.iconImgV.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.iconImgV.snp_rightMargin).offset(20)
            make.centerY.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.rightImgV)
        self.rightImgV.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.centerY.equalTo(self.contentView)
        }
        
        self.contentView.addSubview(self.subtitleLabel)
        self.subtitleLabel.snp.makeConstraints { (make) in
            make.right.equalTo(self.rightImgV.snp_leftMargin).offset(-15)
            make.centerY.equalTo(self.contentView)
        }
    }
}
