//
//  XBBMineViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBMineViewController: XBBBaseViewController {
    
    private lazy var viewModel: MineViewModel = {
        let viewModel = MineViewModel()
        return viewModel
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame:CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.backgroundColor = kBackgroundColor
        
        tableView.register(XBBListTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBListTableViewCell.self))
        return tableView
    }()
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_setupNav()
        xbb_setupView()
        xbb_loadLayout()
    }
}

extension XBBMineViewController {
    
    func xbb_setupNav() {
//        self.navBarBackgroundAlpha = 0
        self.navBarBarTintColor = kThemeColor
        setLeftItem(image: UIImage(named: "personal_sz")!)
        setRightItem(image: UIImage(named: "personal_xiaoxi")!)
    }
    
    func xbb_setupView() {
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: kNavHeight, left: 0, bottom: kTabBarHeight, right: 0))
        }
    }
    
    func xbb_loadLayout() {
        self.viewModel.loadLayout()
    }
    
    override func clickLeftItem(_ button: UIButton) {
        self.navigationController?.pushViewController(XBBSetViewController(), animated: true)
    }
    
    override func clickRightItem(_ button: UIButton) {
        self.navigationController?.pushViewController(XBBMessageViewController(), animated: true)
    }
}

extension XBBMineViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.layouts.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.layouts[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBListTableViewCell.self), for: indexPath) as! XBBListTableViewCell
        cell.layoutModel = self.viewModel.layouts[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.layouts[indexPath.section][indexPath.row]
        if model.className! == "XBBSealOrProxyViewController" {
            let vc = XBBSealOrProxyViewController()
            vc.type = model.layout_type!
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = NSClassFromString("XiongBaobao" + "." + model.className!) as! UIViewController.Type //指定类的类型
            self.navigationController?.pushViewController(vc.init(), animated: true)
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
