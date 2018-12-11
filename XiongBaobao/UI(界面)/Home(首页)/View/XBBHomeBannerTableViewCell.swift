//
//  HomeBannerTableViewCell.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/28.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import SBCycleScrollView

class HomeBannerTableViewCell: UITableViewCell {
    
    private lazy var bannerView: CycleScrollView = {
        var options = CycleOptions()
        options.scrollTimeInterval = 5.0
        options.pageStyle = .chimayo
        options.radius = 5
        options.currentPageDotColor = .white
        let banner = CycleScrollView.initScrollView(frame: CGRect.zero, delegate: self, placehoder: UIImage(named: "home_banner"), cycleOptions: options)
        banner.imageURLStringsGroup = ["https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3711690120,1162131576&fm=27&gp=0.jpg","https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3711690120,1162131576&fm=27&gp=0.jpg","https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=3711690120,1162131576&fm=27&gp=0.jpg"]
        return banner
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        self.contentView.addSubview(self.bannerView)
        self.bannerView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HomeBannerTableViewCell: CycleScrollViewDelegate {
    func didSelectedCycleScrollView(_ cycleScrollView: CycleScrollView, _ Index: NSInteger) {
        
    }
}
