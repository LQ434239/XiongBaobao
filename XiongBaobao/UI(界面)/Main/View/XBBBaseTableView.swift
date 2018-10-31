//
//  XBBBaseTableView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/15.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit
import DZNEmptyDataSet

enum TableViewState {
    case `default`
    case loading
    case noData
    case networkFail
}

//定义闭包类型(这个是在类外部定义)
typealias callBackType = () -> () //这个是在类外部定义

class XBBBaseTableView: UITableView {
    
    var temNoDataTitle: String = ""
    var noDataImgName: String = "noData"
    var noDataTitle: String = ""
    var noDataDetailTitle: String = ""
    var isShowAgainGet: Bool = false
    
    var againLoad: callBackType?
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .automatic
        }
        self.setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: lazy
    private lazy var bgView: UIView = {
        let view = UIView.init()
        view.backgroundColor = kWhite
        return view
    }()
    
    private lazy var loadImgV: UIImageView = {
        let imageV = UIImageView.init()
        var array: [UIImage] = []
        for i in 1..<11 {
            let image = UIImage.init(named: "loading_\(i)")
            array.append(image!)
        }
        imageV.animationImages = array
        imageV.animationDuration = 1
        return imageV
    }()
}

extension XBBBaseTableView {
    func setupUI() {
        self.backgroundColor = kBackgroundColor;
        self.emptyDataSetSource = self;
        self.emptyDataSetDelegate = self;
        self.showsVerticalScrollIndicator = false;
        self.showsHorizontalScrollIndicator = false;
        self.separatorStyle = .none;
        if self.style == .grouped {
            self.tableHeaderView = UIView.init(frame: CGRect(x: 0, y: 0, width: 0, height: CGFloat.leastNormalMagnitude))
        }
        self.tableFooterView = UIView()
        
        self.addSubview(self.bgView)
        self.bgView.addSubview(self.loadImgV)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.bgView.frame = self.frame
        self.loadImgV.snp.makeConstraints { (make) in
            make.center.equalTo(self.bgView)
        }
    }
}

extension XBBBaseTableView: DZNEmptyDataSetSource,DZNEmptyDataSetDelegate {
    func image(forEmptyDataSet scrollView: UIScrollView!) -> UIImage! {
        return UIImage.init(named: self.noDataImgName)
    }
    
    func title(forEmptyDataSet scrollView: UIScrollView!) -> NSAttributedString! {
        return NSAttributedString.init(string: self.temNoDataTitle, attributes: [.font: BoldFontSize(16),.foregroundColor: kTextColor6])
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
}

extension XBBBaseTableView {
    private func showAnimate() {
        UIView.animate(withDuration: 0.15, animations: {
            self.bgView.backgroundColor = UIColor.white
            self.bgView.alpha = 1;
        }) { (finished) in
            self.bgView.isHidden = false
        }
        self.loadImgV.startAnimating()
    }
    
    private func dismissAnimate() {
        UIView.animate(withDuration: 0.25, animations: {
            self.bgView.backgroundColor = UIColor.clear
            self.bgView.alpha = 0;
        }) { (finished) in
            self.bgView.isHidden = true
        }
    }
    
    func state(state: TableViewState) {
        switch state {
        case .loading:
            self.showAnimate()
        case .noData:
            self.temNoDataTitle = self.noDataTitle
            self.noDataImgName = "noData"
            self.noDataDetailTitle = "";
            self.isShowAgainGet = false;
            self.dismissAnimate()
        case .networkFail:
            self.temNoDataTitle = "无网络可用"
            self.noDataImgName = "net_error"
            self.noDataDetailTitle = "请检查当前网络状态及熊保宝网络权限";
            self.isShowAgainGet = true
            self.dismissAnimate()
        default:
            self.dismissAnimate()
        }
        self.reloadEmptyDataSet()
    }
}

