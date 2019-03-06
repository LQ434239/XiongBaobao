//
//  PreserveViewModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/14.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class PreserveViewModel: NSObject {
    var page: Int = 1
    
    var parameters: [String: Any] = ["pageSize": 15]
    
    var tableView: XBBEmptyDataTableView?
    
    var dataSource = [PreserveModel]()
}

extension PreserveViewModel {
    func loadDataList(type: String) {
        self.page = 1
        self.parameters["pages"] = 1
        self.parameters["type"] = type
        NetworkManager.shard.requestJSONDataWithTarget(target: PreserveAPI.basicList(parameters: self.parameters)) { (status, result, message) in
            if status == .success {
                self.dataSource.removeAll()
                guard let jsonArray = result!["records"].arrayObject else { return }
                if jsonArray.count > 0 {
                    for dic in jsonArray {
                        let model = PreserveModel(JSON: dic as! Dictionary)
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
    
    func loadMoreDataList() {
        self.parameters["pages"] = self.page
        NetworkManager.shard.requestJSONDataWithTarget(target: PreserveAPI.basicList(parameters: self.parameters)) { (status, result, message) in
            if status == .success {
                self.tableView?.mj_footer.endRefreshing()
                guard let jsonArray = result!["records"].arrayObject else { return }
                if jsonArray.count > 0 {
                    for dic in jsonArray {
                        let model = PreserveModel(JSON: dic as! Dictionary)
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
