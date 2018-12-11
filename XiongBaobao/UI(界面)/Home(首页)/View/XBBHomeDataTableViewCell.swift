//
//  XBBHomeDataTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/28.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBHomeDataTableViewCell: UITableViewCell {
    
    private lazy var titleButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = FontSize(20)
        button.setTitle("保全数据", for: .normal)
        button.setTitleColor(kTextColor3, for: .normal)
        return button
    }()

    private lazy var totalLabel: UILabel = {
        var label = createLabel()
        label.attributedText = String.stringCustom(prefix: "0", suffix: "\n保全总数", rangFont: FontSize(10), rangColor: kTextColor9)
        return label
    }()
    
    private lazy var localLabel: UILabel = {
        var label = createLabel()
        label.attributedText = String.stringCustom(prefix: "0", suffix: "\n本地保全", rangFont: FontSize(10), rangColor: kTextColor9)
        return label
    }()
    
    private lazy var contractLabel: UILabel = {
        var label = createLabel()
        label.attributedText = String.stringCustom(prefix: "0", suffix: "\n合同保全", rangFont: FontSize(10), rangColor: kTextColor9)
        
        return label
    }()
    
    private func createLabel() -> UILabel {
        let label = UILabel()
        label.textColor = kTextColor3
        label.font = FontSize(30)
        label.numberOfLines = 2
        label.textAlignment = .center
        return label
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XBBHomeDataTableViewCell {
    func setupView() {
        self.selectionStyle = .none
        
        let width = (kScreenWidth - 24) / 3
        
        self.contentView.addSubview(self.totalLabel)
        self.totalLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.top.bottom.equalTo(0)
            make.width.equalTo(width)
        }
        
        self.contentView.addSubview(self.localLabel)
        self.localLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.left.equalTo(self.totalLabel.snp_rightMargin)
            make.width.equalTo(width)
        }
        
        self.contentView.addSubview(self.contractLabel)
        self.contractLabel.snp.makeConstraints { (make) in
            make.top.bottom.equalTo(0)
            make.right.equalTo(-12)
            make.width.equalTo(width)
        }
    }
}
