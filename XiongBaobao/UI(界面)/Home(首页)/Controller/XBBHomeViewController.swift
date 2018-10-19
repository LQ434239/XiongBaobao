//
//  XBBHomeViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBHomeViewController: XBBBaseViewController {
    
    var num = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        MBProgressHUD.showErrorWithText("")
    }
    
    // MARK: lazy
    
    private lazy var tableView: XBBBaseTableView = {
        let tableView = XBBBaseTableView(frame:self.view.bounds, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = kWhite
        weak var weakSelf = self
        tableView.againLoad = {
            
        }
        tableView.state(state: .networkFailState)
        
//        tableView.mj_header = MJRefreshNormalHeader(refreshingBlock: { () in
//            tableView.mj_header.endRefreshing()
//        })
//        tableView.mj_footer = MJRefreshBackNormalFooter(refreshingBlock: { () in
//             tableView.mj_footer.endRefreshing()
//        })
        return tableView
    }()
}

extension XBBHomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return num
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = RandomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
