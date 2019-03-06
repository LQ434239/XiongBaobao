//
//  CourseViewModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/12.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class CourseViewModel: NSObject {
    var page: Int = 1
    
    var parameters: [String: Int] = ["rows": 15]
    
    var tableView: XBBEmptyDataTableView?
    
    var dataSource = [CourseModel]()
}

extension CourseViewModel {
    
    func loadDataList() {
        self.page = 1
        self.parameters["page"] = 1
        NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.course(parameters: self.parameters)) { (status, result, message) in
            if status == .success {
                self.dataSource.removeAll()
                guard let jsonArray = result!["records"].arrayObject else { return }
                if jsonArray.count > 0 {
                    for dic in jsonArray {
                        let model = CourseModel(JSON: dic as! Dictionary)
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
        self.parameters["page"] = self.page
        NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.course(parameters: self.parameters)) { (status, result, message) in
            if status == .success {
                self.tableView?.mj_footer.endRefreshing()
                guard let jsonArray = result!["records"].arrayObject else { return }
                if jsonArray.count > 0 {
                    for dic in jsonArray {
                        let model = CourseModel(JSON: dic as! Dictionary)
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
    
    func loadCourseDetail(indexPath: IndexPath, success: @escaping (String, String) -> Void) {
        let model = self.dataSource[indexPath.section]
        NetworkManager.shard.requestJSONDataWithTarget(target: MineAPI.courseDetail(id: model.dataId!)) { (status, result, message) in
            if status == .success {
                guard let dic = result!["content"].string else { return }
                success(model.title!, dic)
            }
        }
    }
}
