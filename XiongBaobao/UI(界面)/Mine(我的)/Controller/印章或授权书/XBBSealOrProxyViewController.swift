//
//  XBBSealOrProxyViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/10.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBSealOrProxyViewController: XBBBaseViewController {

    var type: Int = 0 //0.印章 1.授权书
    
    private lazy var viewModel: SealOrProxyViewModel = {
        let viewModel = SealOrProxyViewModel()
        viewModel.tableView = self.tableView
        return viewModel
    }()
    
    private lazy var tableView: XBBEmptyDataTableView = {
        let tableView = XBBEmptyDataTableView(frame:CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.noDataTitle = self.type == 1 ? "暂时还没有授权书哦！": "暂时还没有印章书哦！"
        
        tableView.register(XBBSealOrProxyTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBSealOrProxyTableViewCell.self))
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(xbb_loadDataList))
        tableView.mj_header = header
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_setupNav()
        xbb_setupView()
        xbb_loadDataList()
    }
}

extension XBBSealOrProxyViewController {
    
    func xbb_setupNav() {
         self.title = self.type == 1 ? "我的授权书": "我的印章";
    }
    
    func xbb_setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc func xbb_loadDataList() {
        self.viewModel.loadDataList(type: self.type)
    }
}

extension XBBSealOrProxyViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.type == 1 {
            return self.viewModel.proxyData.count
        }
        return self.viewModel.sealData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBSealOrProxyTableViewCell.self), for: indexPath) as! XBBSealOrProxyTableViewCell
        if self.type == 1 {
            cell.proxyModel = self.viewModel.proxyData[indexPath.row]
        } else {
            cell.sealModel = self.viewModel.sealData[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (action, indexPath) in
            
        }
        
        let renameAction = UITableViewRowAction(style: .normal, title: "重命名") { (action, indexPath) in
            
        }
        renameAction.backgroundColor = kThemeColor
        return [deleteAction, renameAction]
    }
}
