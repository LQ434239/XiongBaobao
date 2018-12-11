//
//  XBBHomeViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBHomeViewController: XBBBaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(kNavHeight)
            make.left.right.equalTo(0)
            make.bottom.equalTo(-kTabBarHeight)
        }
    }
    
    // MARK: lazy
    private lazy var tableView: BaseTableView = {
        let tableView = BaseTableView(frame:CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        
        tableView.againLoad = { [unowned self] in
            
        }
        
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
        return 4
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.backgroundColor = randomColor()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
