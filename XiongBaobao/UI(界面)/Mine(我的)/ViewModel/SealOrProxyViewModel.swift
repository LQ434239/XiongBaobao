//
//  SealOrProxyViewModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/13.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class SealOrProxyViewModel: NSObject {
    
    var tableView: XBBEmptyDataTableView?
    
    var sealData = [SealModel]()
    var proxyData = [ProxyModel]()
}

extension SealOrProxyViewModel {
    
    func loadDataList(type: Int) {
        if type == 1 {
            NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.proxyBookList) { (status, result, message) in
                if status == .success {
                    self.proxyData.removeAll()
                    guard let jsonArray = result!.arrayObject else { return }
                    if jsonArray.count > 0 {
                        for dic in jsonArray {
                            let model = ProxyModel(JSON: dic as! Dictionary)
                            self.proxyData.append(model!)
                        }
                    } else {
                        self.tableView?.state(state: .noData)
                    }
                } else if status == .dataError {
                    SVProgressHUD.showError(withStatus: message)
                } else {
                    self.tableView?.state(state: .networkFail)
                }
                self.tableView?.reloadData()
                self.tableView?.mj_header.endRefreshing()
            }
        } else {
            NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.sealList) { (status, result, message) in
                if status == .success {
                    self.sealData.removeAll()
                    guard let jsonArray = result!.arrayObject else { return }
                    if jsonArray.count > 0 {
                        for dic in jsonArray {
                            let model = SealModel(JSON: dic as! Dictionary)
                            self.sealData.append(model!)
                        }
                    } else {
                        self.tableView?.state(state: .noData)
                    }
                } else if status == .dataError {
                    SVProgressHUD.showError(withStatus: message)
                } else {
                    self.tableView?.state(state: .networkFail)
                }
                self.tableView?.reloadData()
                self.tableView?.mj_header.endRefreshing()
            }
        }
    }
}
