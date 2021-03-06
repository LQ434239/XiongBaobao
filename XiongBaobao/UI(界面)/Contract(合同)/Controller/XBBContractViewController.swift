//
//  XBBContractViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/29.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBContractViewController: UIViewController {

    var isProxyC: Bool = false //是否是代理合同
    
    var status: String = "" //默认加载全部
    
    private lazy var viewModel: ContractViewModel = {
        let viewModel = ContractViewModel()
        viewModel.tableView = self.tableView
        return viewModel
    }()
    
    private lazy var tableView: XBBEmptyDataTableView = {
        let tableView = XBBEmptyDataTableView(frame:CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.noDataTitle = "暂时没有合同哦！"
        
        tableView.register(XBBContractTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBContractTableViewCell.self))
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadDataList))
        tableView.mj_header = header
        
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreDataList))
        tableView.mj_footer = footer
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        xbb_setupView()
        loadDataList()
    }
}

// MARK: event
extension XBBContractViewController {
    
    func xbb_setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc func loadDataList() {
        self.viewModel.xbb_loadDataList(isProxyC: self.isProxyC, status: self.status)
    }
    
    @objc func loadMoreDataList() {
        self.viewModel.xbb_loadMoreDataList(isProxyC: self.isProxyC, status: self.status)
    }
}

extension XBBContractViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBContractTableViewCell.self), for: indexPath) as! XBBContractTableViewCell
        cell.model = self.viewModel.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = self.viewModel.dataSource[indexPath.row]
        switch selectedModel.status {
        case 0, 1, 2, 4, 5, 6: //待审核、待我签署、待TA签署、已完成、已拒签、已失效
            let vc = XBBContractInfoViewController()
            vc.contractModel = selectedModel
            vc.isProxyC = self.isProxyC
            self.navigationController?.pushViewController(vc, animated: true)
        default: //待发送
            let vc = XBBContractHTMLViewController()
            vc.contractModel = selectedModel
            vc.title = "发送合同"
            vc.isProxyC = self.isProxyC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    
        self.viewModel.tableView(tableView, didSelectRowAt: indexPath)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
