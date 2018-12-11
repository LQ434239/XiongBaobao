//
//  XBBHomeViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBHomeViewController: XBBBaseViewController {
    
    // MARK: lazy
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame:CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.white
        tableView.separatorStyle = .none
        
        tableView.register(XBBHomeBannerTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBHomeBannerTableViewCell.self))
        tableView.register(XBBHomeDataTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBHomeDataTableViewCell.self))
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.top.equalTo(kNavHeight)
            make.left.right.bottom.equalTo(0)
        }
    }
}

extension XBBHomeViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBHomeDataTableViewCell.self), for: indexPath)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBHomeBannerTableViewCell.self), for: indexPath)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
}
