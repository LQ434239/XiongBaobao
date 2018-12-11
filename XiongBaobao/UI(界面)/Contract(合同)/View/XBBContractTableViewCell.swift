//
//  ContractTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/29.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class ContractTableViewCell: UITableViewCell {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor3
        label.font = FontSize(16)
        label.text = "合同标题"
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor9
        label.font = FontSize(12)
        label.text = "2018-01-01"
        return label
    }()

    private var phoneLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor6
        label.font = FontSize(12)
        label.text = "12345678910"
        return label
    }()
    
    private var statusLabel: UILabel = {
        let label = UILabel()
        label.textColor = kThemeColor
        label.font = FontSize(10)
        label.text = "待发送"
        label.textAlignment = .center
        return label
    }()
    
    private var dotView: UIView = {
        let view = UIView()
//        view.isHidden = true
        view.backgroundColor = UIColor.red
        return view
    }()
    
    var model: ContractModel? {
        didSet {
            self.titleLabel.text = model!.name
            self.timeLabel.text = String((model?.time.prefix(10))!)
            self.dotView.isHidden = model!.isViewed == 1
            self.statusLabel.text = model!.statusName
            self.statusLabel.snp.updateConstraints { (make) in
                make.width.equalTo(model!.statusName.widthForFont(font: FontSize(10)) + 5)
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
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        super.setHighlighted(highlighted, animated: animated)
        self.dotView.backgroundColor = UIColor.red
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.dotView.backgroundColor = UIColor.red
    }
}

extension ContractTableViewCell {
    func setupView() {
        self.contentView.addSubview(self.timeLabel)
        let width: CGFloat = "2018-01-01".widthForFont(font: FontSize(12)) + 5
        self.timeLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.top.equalTo(15)
            make.width.equalTo(width)
        }
        
        self.contentView.addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalTo(self.timeLabel)
            make.width.lessThanOrEqualTo(kScreenWidth - width - 50)
        }
        
        self.contentView.addSubview(self.dotView)
        self.dotView.snp.makeConstraints { (make) in
            make.top.equalTo(self.titleLabel)
            make.right.equalTo(self.titleLabel).offset(3)
            make.size.equalTo(CGSize(width: 6, height: 6))
        }
        self.dotView.corner(radius: 3)
        
        self.contentView.addSubview(self.statusLabel)
        self.statusLabel.snp.makeConstraints { (make) in
            make.right.equalTo(-12)
            make.top.equalTo(self.timeLabel.snp_bottomMargin).offset(15)
            make.size.equalTo(CGSize(width: 35, height: 15))
        }
        self.statusLabel.corner(radius: 1, color: kThemeColor, width: kLineSize) 
//        self.contentView.addSubview(self.phoneLabel)
        
        let lineView = UIView()
        lineView.backgroundColor = kLineColor
        self.contentView.addSubview(lineView)
        lineView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(kLineSize)
        }
    }
}
