//
//  XBBPreserveViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/10.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBPreserveViewController: UIViewController {

    var type: String = ""
    
    private lazy var viewModel: PreserveViewModel = {
        let viewModel = PreserveViewModel()
        viewModel.tableView = self.tableView
        return viewModel
    }()
    
    private lazy var tableView: XBBEmptyDataTableView = {
        let tableView = XBBEmptyDataTableView(frame:CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.noDataTitle = "暂时还没有保全哦！"
        
        tableView.register(XBBPreserveTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBPreserveTableViewCell.self))
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(xbb_loadDataList))
        tableView.mj_header = header
        
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(xbb_loadMoreDataList))
        tableView.mj_footer = footer
        return tableView
    }()
 
    private lazy var preserveButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = kThemeColor
        button.titleLabel?.font = FontSize(12)
        button.setTitle("保 全", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        button.addTarget(self, action: #selector(xbb_clickPreserve(button:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_setupView()
        xbb_loadDataList()
    }
}

extension XBBPreserveViewController {

    func xbb_setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
        
        self.view.addSubview(self.preserveButton)
        self.preserveButton.snp.makeConstraints { (make) in
            make.right.equalTo(-60)
            make.bottom.equalTo(-kBottomSafeSpace-150)
            make.size.equalTo(CGSize(width: 50, height: 50))
        }
        self.preserveButton.corner(radius: 25)
    }
    
    @objc func xbb_loadDataList() {
        self.viewModel.loadDataList(type: self.type)
    }
    
    @objc func xbb_loadMoreDataList() {
        self.viewModel.loadMoreDataList()
    }
    
    @objc func xbb_clickPreserve(button: UIButton) {
        
    }
}

extension XBBPreserveViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBPreserveTableViewCell.self), for: indexPath) as! XBBPreserveTableViewCell
        cell.model = self.viewModel.dataSource[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75.0
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let testifyAction = UITableViewRowAction(style: .default, title: "出证") { (action, indexPath) in
           
        }
        testifyAction.backgroundColor = UIColor(hex: "ff9800")
        
        let checkAction = UITableViewRowAction(style: .default, title: "查看证书") { (action, indexPath) in
            
        }
        checkAction.backgroundColor = UIColor(hex: "ff5900")
        return [testifyAction, checkAction]
    }
}
