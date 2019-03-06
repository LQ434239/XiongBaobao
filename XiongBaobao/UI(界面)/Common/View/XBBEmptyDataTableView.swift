//
//  XBBEmptyDataTableView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/15.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

enum TableViewState {
    case noData
    case networkFail
}

typealias callBackType = () -> ()

class XBBEmptyDataTableView: UITableView {
    
    var noDataImgName: String = "noData"
    var noDataTitle: String = ""
    var noDataDetailTitle: String = ""
    var isShowAgainGet: Bool = false
    
    var isLoading: Bool = true
    
    var againLoad: callBackType?
    
    private lazy var customView: UIView = {
        let view = UIView()
        let imageV = UIImageView.init()
        var array: [UIImage] = []
        for i in 1..<11 {
            let image = UIImage.init(named: "loading_\(i)")
            array.append(image!)
        }
        imageV.animationImages = array
        imageV.animationDuration = 1
        imageV.startAnimating()
        view.addSubview(imageV)
        imageV.snp.makeConstraints { (make) in
            make.center.equalTo(view)
            make.size.equalTo(CGSize(width: 30, height: 30))
        }
        return view
    }()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        xbb_setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension XBBEmptyDataTableView {
    func xbb_setupView() {
        self.backgroundColor = kBackgroundColor
        self.emptyDataSetSource = self
        self.emptyDataSetDelegate = self
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.separatorStyle = .none
        if self.style == .grouped {
            self.tableHeaderView = UIView(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        }
        self.tableFooterView = UIView()
        self.contentInset = UIEdgeInsets(top: 1, left: 0, bottom: 0, right: 0)
    }
}

extension XBBEmptyDataTableView: DZNEmptyDataSetSource, DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage(named: self.noDataImgName)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: self.noDataTitle, attributes: [.font: BoldFontSize(16),.foregroundColor: kTextColor6])
    }
    
    func description(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: self.noDataDetailTitle, attributes: [.font: FontSize(12),.foregroundColor: kTextColor9])
    }
    
    func buttonImage(forEmptyDataSet scrollView: UIScrollView!, for state: UIControl.State) -> UIImage! {
        return self.isShowAgainGet ? UIImage.init(named: "get_net") : nil
    }
    
    func emptyDataSet(_ scrollView: UIScrollView!, didTap button: UIButton!) {
        if let block = self.againLoad {
            block()
        } else {
            self.mj_header.beginRefreshing()
        }
    }
    
    func customView(forEmptyDataSet scrollView: UIScrollView!) -> UIView! {
        return self.isLoading ? self.customView: nil
    }
    
    func backgroundColor(forEmptyDataSet scrollView: UIScrollView!) -> UIColor! {
        return UIColor.white
    }
    
    func emptyDataSetShouldAllowScroll(_ scrollView: UIScrollView!) -> Bool {
        return self.isLoading ? false: true
    }
}

extension XBBEmptyDataTableView {
    
    func state(state: TableViewState) {
        switch state {
        case .noData:
            self.isLoading = false
        case .networkFail:
            self.isLoading = false
            self.noDataTitle = "无网络可用"
            self.noDataImgName = "net_error"
            self.noDataDetailTitle = "请检查当前网络状态及熊保宝网络权限"
            self.isShowAgainGet = true
        }
        reloadEmptyDataSet()
    }
}
