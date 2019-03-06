//
//  XBBCourseViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/10.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBCourseViewController: XBBBaseViewController {

    private lazy var viewModel: CourseViewModel = {
        let viewModel = CourseViewModel()
        viewModel.tableView = self.tableView
        return viewModel
    }()
    
    private lazy var tableView: XBBEmptyDataTableView = {
        let tableView = XBBEmptyDataTableView(frame:CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.noDataTitle = "暂时还没有教程哦！"
        
        tableView.register(XBBCourseTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBCourseTableViewCell.self))
        
        let header = MJRefreshNormalHeader(refreshingTarget: self, refreshingAction: #selector(loadDataList))
        tableView.mj_header = header
        
        let footer = MJRefreshBackNormalFooter(refreshingTarget: self, refreshingAction: #selector(loadMoreDataList))
        tableView.mj_footer = footer
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_setupNav()
        xbb_setupView()
        loadDataList()
    }
}

extension XBBCourseViewController {
    func xbb_setupNav() {
        self.title = "在线教程"
    }
 
    func xbb_setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
    @objc func loadDataList() {
        self.viewModel.loadDataList()
    }
    
    @objc func loadMoreDataList() {
        self.viewModel.loadMoreDataList()
    }
}

extension XBBCourseViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBCourseTableViewCell.self), for: indexPath) as! XBBCourseTableViewCell
        cell.model = self.viewModel.dataSource[indexPath.section]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return CGFloat.leastNormalMagnitude
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.viewModel.loadCourseDetail(indexPath: indexPath) { (title, html) in
            let vc = XBBHTMLViewController()
            vc.title = title
            vc.html = html
            self.navigationController?.pushViewController(vc, animated: true)
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
}




