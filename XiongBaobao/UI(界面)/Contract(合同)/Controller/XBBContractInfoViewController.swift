//
//  XBBContractInfoViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/30.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBContractInfoViewController: XBBBaseViewController {
    
    var contractModel: ContractModel?
    
    private lazy var viewModel: ContractInfoViewModel = {
        let viewModel = ContractInfoViewModel()
        viewModel.tableView = self.tableView
        return viewModel
    }()
    
    
    private lazy var bottomView: XBBTwoBottomButtonView = {
        let view = XBBTwoBottomButtonView()
        view.delegate = self
        return view
    }()
    
    private lazy var tableView: XBBEmptyDataTableView = {
        let tableView = XBBEmptyDataTableView(frame:CGRect.zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self

        tableView.register(XBBContractInfoTableViewCell.self, forCellReuseIdentifier: NSStringFromClass(XBBContractInfoTableViewCell.self))
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNav()
        setupView()
        loadContractData()
    }
}

extension XBBContractInfoViewController {
    
    func setupNav() {
        self.title = self.contractModel?.statusName
    }
    
    func setupView() {
        
        self.view.backgroundColor = UIColor.white
        
        self.view.addSubview(self.bottomView)
        self.bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.height.equalTo(50)
            make.bottom.equalTo(-kBottomSafeSpace)
        }
        
        self.view.addSubview(self.tableView)
        self.tableView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: kNavHeight, left: 0, bottom: kBottomSafeSpace + 50, right: 0))
        }
    }
}

extension XBBContractInfoViewController: XBBTwoBottomButtonViewDelegate {
    
    func clickLeftButton(button: UIButton) {
        switch self.contractModel?.status {
//        case 1: //拒绝签署
//            let vc = XBBRefuseSignedViewController()
//            self.navigationController?.pushViewController(vc, animated: true)
        case 4: //立即下载
            NSObject.showSheetView(title: "立即下载：", message: nil, actionArray: ["下载合同", "下载发送方视频", "下载签署方视频"]) { [weak self] (index) in
                self!.viewModel.downloadFile(index: index, model: self!.contractModel!)
            }
        default: //拒绝保全
            self.viewModel.preserveContract(model: self.contractModel!, isPreserve: 0)
        }
    }
    
    func clickRightButton(button: UIButton) {
        switch self.contractModel?.status {
        case 1: //立即签署
            let vc = XBBContractHTMLViewController()
            vc.contractModel = self.contractModel
            self.navigationController?.pushViewController(vc, animated: true)
        case 4: //申请出证
            let vc = XBBApplyTestifyViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        default: //立即保全
            self.viewModel.preserveContract(model: self.contractModel!, isPreserve: 1)
        }
    }
}

extension XBBContractInfoViewController {
    
    func loadContractData() {
        self.viewModel.loadContract(model: self.contractModel!) { [weak self] (contract) in
            if contract.status == 0 { //待审核
                let user = UserManager.shard.read()
                if !isProxyC || (user.phoneNumber == contract.phoneNumber) {
                    self!.tableView.snp.updateConstraints { (make) in
                        make.bottom.equalTo(0)
                    }
                } else {
                    self!.bottomView.setButtonTitle(type: .default)
                }
            }
            if contract.status == 2 { //待TA签署
                self!.setRightItem(title: "撤回", titleColor: kTextColor6)
            }
            if contract.status == 1 { //待我签署
                self!.bottomView.setButtonTitle(type: .waite)
            }
            if contract.status == 4 && !(contract.certificateNumber?.isEmpty)! { //已完成
                self!.bottomView.setButtonTitle(type: .finish)
            }
        }
    }
    
    override func clickRightItem(_ button: UIButton) { //撤销合同
        NSObject.showAlertView(title: "确定要撤销这个合同？", message: nil, cancelTitle: "取消", confirmTitle: "确定", cancelHandel: nil) { (action) in
            self.viewModel.repealContract(model: self.contractModel!)
        }
    }
}

extension XBBContractInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.viewModel.contractInfos.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.contractInfos[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(XBBContractInfoTableViewCell.self), for: indexPath) as! XBBContractInfoTableViewCell
        cell.model = self.viewModel.contractInfos[indexPath.section][indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = XBBContractInfoHeader()
        header.viewForHeader(section: section)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30.0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = self.viewModel.contractInfos[indexPath.section][indexPath.row]
        switch model.type {
        case 0: //合同
            let vc = XBBHTMLViewController()
            vc.html = model.content!
            vc.title = model.title
            self.navigationController?.pushViewController(vc, animated: true)
        case 2: //视频
            let vc = XBBPlayerViewController()
            vc.requesURL = model.content
            vc.title = model.title
            self.navigationController?.pushViewController(vc, animated: true)
        default: //授权书，附件
            let vc = XBBHTMLViewController()
            vc.requesURL = model.content!
            vc.title = model.title
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
