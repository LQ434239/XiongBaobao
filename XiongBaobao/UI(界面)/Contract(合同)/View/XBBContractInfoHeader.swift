//
//  XBBContractInfoHeader.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/30.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBContractInfoHeader: UIView {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = kTextColor9
        label.font = FontSize(12)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = kBackgroundColor
        addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.left.equalTo(12)
            make.centerY.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XBBContractInfoHeader {
    func viewForHeader(section: Int) {
        if section == 0 {
            self.titleLabel.text = "合同正文及附件"
        } else if section == 1 {
            self.titleLabel.text = "采集的视频"
        } else {
            self.titleLabel.text = "授权书"
        }
    }
}
