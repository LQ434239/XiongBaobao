//
//  MessageViewModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/11.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class MessageViewModel: NSObject {
    var page: Int = 1
    
    var parameters: [String: Int] = ["pageSize": 15]
    
    var tableView: XBBEmptyDataTableView?
    
    var dataSource = [MessageModel]()
}

extension MessageViewModel {
    
    func loadDataList(count: @escaping (Int) -> Void) {
        self.page = 1
        self.parameters["pages"] = 1
        NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.messageList(parameters: self.parameters)) { (status, result, message) in
            if status == .success {
                self.dataSource.removeAll()
                guard let jsonArray = result!["records"].arrayObject else { return }
                if jsonArray.count > 0 {
                    for dic in jsonArray {
                        let model = MessageModel(JSON: dic as! Dictionary)
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
            count(self.dataSource.count)
            self.tableView?.reloadData()
            self.tableView?.mj_header.endRefreshing()
        }
    }
    
    func loadMoreDataList() {
        self.parameters["pages"] = self.page
        NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.messageList(parameters: self.parameters)) { (status, result, message) in
            if status == .success {
                self.tableView?.mj_footer.endRefreshing()
                guard let jsonArray = result!["records"].arrayObject else { return }
                if jsonArray.count > 0 {
                    for dic in jsonArray {
                        let model = MessageModel(JSON: dic as! Dictionary)
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
    
    func delMessage(type: Int, indexPath: IndexPath?) { //1.清空 2.一条
        var parameters = ["type": type]
        if type == 0 {
            parameters["msgId"] = self.dataSource[indexPath!.row].dataId
        }
        NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.delMessage(parameters: parameters)) { (status, result, message) in
            if status == .success {
                if type == 0 {
                    self.dataSource.remove(at: indexPath!.row)
                } else {
                    self.dataSource.removeAll()
                    self.tableView?.state(state: .noData)
                }
                self.tableView?.reloadData()
            } else {
                SVProgressHUD.showError(withStatus: message)
            }
        }
    }
    
    func readmessage(indexPath: IndexPath) { //阅读消息
        let selectedModel = self.dataSource[indexPath.row]
        NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.readMsg(msgId: selectedModel.dataId!)) { (status, result, message) in
            if status == .success {
                if selectedModel.state == 0 {
                    for model in self.dataSource {
                        if model.dataId == selectedModel.dataId {
                            model.state = 1
                            break
                        }
                    }
                    self.tableView?.reloadData()
                }
            }
        }
    }
}
