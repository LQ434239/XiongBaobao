//
//  ContractListViewModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/29.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class ContractListViewModel: NSObject {
    
    var page: Int = 1
    
    var isB: Int {
        return UserDefaults.standard.integer(forKey: "isB")
    }
    
    var parameters: [String: Any] = ["pageSize": "15"]
    
    var tableView: XBBEmptyDataTableView?
    
    var dataSource = [ContractModel]()
}

extension ContractListViewModel {
    func loadDataList(isProxyC: Bool, status: String) {
        self.page = 1
        self.parameters["pages"] = 1
        self.parameters["state"] = status
        NetworkManager.shard.requestJSONDataWithTarget(target: ContractAPI.contractList(isProxyC: isProxyC, parameters: self.parameters)) { (status, result, message) in
            if status == .success {
                self.dataSource.removeAll()
//                guard let isB = result["condition"]["isB"].int else { return }
//                print(result["condition"]["isB"])
                guard let jsonArray = result!["records"].arrayObject else { return }
                if jsonArray.count > 0 {
                    for dic in jsonArray {
                        let model = ContractModel(JSON: dic as! Dictionary)
                        self.dataSource.append(model!)
                    }
                    self.page += 1
                } else {
                    self.tableView?.state(state: .noData)
                }
                
                self.tableView?.mj_footer.resetNoMoreData()
            } else if status == .dataError {
                SVProgressHUD.showError(withStatus: message)
            } else {
                self.tableView?.state(state: .networkFail)
            }
            self.tableView?.reloadData()
            self.tableView?.mj_header.endRefreshing()
        }
    }
    
    func loadMoreDataList(isProxyC: Bool, status: String) {
        self.parameters["pages"] = self.page
        NetworkManager.shard.requestJSONDataWithTarget(target: ContractAPI.contractList(isProxyC: isProxyC, parameters: self.parameters)) { (status, result, message) in
            if status == .success {
                self.tableView?.mj_footer.endRefreshing()
                guard let jsonArray = result!["records"].arrayObject else { return }
                if jsonArray.count > 0 {
                    for dic in jsonArray {
                        let model = ContractModel(JSON: dic as! Dictionary)
                        self.dataSource.append(model!)
                    }
                    self.page += 1
                } else {
                    self.tableView?.mj_footer.endRefreshingWithNoMoreData()
                }
                self.tableView?.reloadData()
            } else {
                self.tableView?.mj_header.endRefreshing()
                SVProgressHUD.showError(withStatus: message)
            }
            self.tableView?.reloadData()
        }
    }
}

extension ContractListViewModel {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedModel = self.dataSource[indexPath.row]
        if selectedModel.isViewed == 0 { //消息未查看
            for model in self.dataSource {
                if model.data_id == selectedModel.data_id {
                    model.isViewed = 1
                    break
                }
            }
            tableView.reloadData()
        }
    }
}
