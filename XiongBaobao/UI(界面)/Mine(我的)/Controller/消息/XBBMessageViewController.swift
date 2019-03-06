//
//  XBBMessageViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/10.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBMessageViewController: XBBBaseViewController {

    private lazy var viewModel: MessageViewModel = {
        let viewModel = MessageViewModel()
        viewModel.tableView = self.tableView
        return viewModel
    }()
    
    private lazy var tableView: XBBEmptyDataTableView = {
        let tableView = XBBEmptyDataTableView(frame:CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.noDataTitle = "暂时还没有消息哦！"
        
        tableView.register(XBBMessageTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBMessageTableViewCell.self))
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(xbb_loadDataList))
        tableView.mj_header = header
        
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(xbb_loadMoreDataList))
        tableView.mj_footer = footer
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_setupNav()
        xbb_setupView()
        xbb_loadDataList()
    }
}

extension XBBMessageViewController {
    func xbb_setupNav() {
        self.title = "我的消息"
    }
    
    func xbb_setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc func xbb_loadDataList() {
        self.viewModel.loadDataList { (count) in
            if count > 0 {
                self.setRightItem(title: "清空", titleColor: kTextColor3)
            } else {
                self.navigationItem.rightBarButtonItems?.removeAll()
            }
        }
    }
    
    @objc func xbb_loadMoreDataList() {
        self.viewModel.loadMoreDataList()
    }
    
    override func clickRightItem(_ button: UIButton) {
        NSObject.showAlertView(title: "提示", message: "确定要清空消息？", cancelTitle: "取消", confirmTitle: "确定", cancelHandel: nil) { (action) in
            self.viewModel.delMessage(type: 1, indexPath: nil)
        }
    }
}

extension XBBMessageViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBMessageTableViewCell.self), for: indexPath) as! XBBMessageTableViewCell
        cell.model = self.viewModel.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.readmessage(indexPath: indexPath)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .destructive, title: "删除") { (action, indexPath) in
            self.viewModel.delMessage(type: 0, indexPath: indexPath)
        }
        return [deleteAction]
    }
}
