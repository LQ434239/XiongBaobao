//
//  ContractInfoTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/30.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class ContractInfoTableViewCell: UITableViewCell {

    private lazy var contractImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "icon_ht"))
        return imgV
    }()
    
    private lazy var videoImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage.image(kTextColor9))
        imgV.corner(radius: 2)
        return imgV
    }()
    
    private lazy var playImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "cell_video_bf"))
        return imgV
    }()
    
    private lazy var bookImgV: UIImageView = {
        let imgV = UIImageView(image: UIImage(named: "icon_ht"))
        return imgV
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontSize(16)
        label.textColor = kTextColor3
        return label
    }()
    
    var model: ContractInfo? {
        didSet {
            self.titleLabel.text = model?.title
            self.contractImgV.isHidden = model?.type != 0
            self.videoImgV.isHidden = model?.type != 2
            self.playImgV.isHidden = model?.type != 2
            self.bookImgV.isHidden = model?.type != 3
            
            if model?.type == 2 {
                self.videoImgV.kf.setImage(with: URL(string: (model?.thb)!))
            }
        }
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var frame:CGRect {
        didSet {
            var newFrame = frame
            newFrame.origin.x += 10
            newFrame.origin.y += 5
            newFrame.size.width -= 20
            newFrame.size.height -= 10
            super.frame = newFrame
        }
    }
}

extension ContractInfoTableViewCell {
    func setupView() {
        self.selectionStyle = .none
        
        self.contentView.addSubview(self.contractImgV)
        self.contractImgV.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalTo(self.contentView)
            make.size.equalTo(CGSize(width: 60, height: 60))
        }
        
        self.contentView.addSubview(self.videoImgV)
        self.videoImgV.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contractImgV)
        }

        self.contentView.addSubview(self.playImgV)
        self.playImgV.snp.makeConstraints { (make) in
            make.center.equalTo(self.videoImgV)
        }
        
        self.contentView.addSubview(self.bookImgV)
        self.bookImgV.snp.makeConstraints { (make) in
            make.edges.equalTo(self.contractImgV)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(self.contractImgV.snp_rightMargin).offset(20)
            make.centerY.equalTo(self.contentView)
        }
    }
}
