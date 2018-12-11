//
//  ContractInfoViewModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/30.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class ContractInfo: NSObject {
    var title: String?
    var thb: String?
    var content: String? //url、html
    var type: Int = 0 //0：合同，1：附件，2：视频，3：授权书
}

class ContractInfoViewModel: NSObject {
    
    var tableView: XBBEmptyDataTableView?
    
    var contractInfos = [[ContractInfo]]()

    var contractModel: ContractModel?
}

extension ContractInfoViewModel {
    func loadContract(model: ContractModel, success: @escaping (_ model: ContractModel) -> Void) {
        
        let parameters = ["transmissionId": model.data_id, "state": model.status!]
        NetworkManager.shard.requestJSONDataWithTarget(target: ContractAPI.contractById(parameters: parameters)) { (status, result, message) in
            if status == .success {
                guard let jsonDic = result!.dictionaryObject else { return }
                
                let contractModel = ContractModel(JSON: jsonDic)!
                self.contractModel = contractModel
                
                var array = [[ContractInfo]]()
                var array1 = [ContractInfo]()
                var array2 = [ContractInfo]()
                var array3 = [ContractInfo]()
                
                let info = ContractInfo()
                info.title = contractModel.name
                info.type = 0
                if contractModel.status == 0 ||
                    contractModel.status == 4 {
                    info.content = "<img src=\"" + contractModel.contractUrl! + "?imageslim\"/>"
                } else {
                    info.content = contractModel.content
                }
                
                array1.append(info)
                
                if (contractModel.appendiceList?.count)! > 0 && contractModel.status != 3 {
                    let info = ContractInfo()
                    info.title = "\(contractModel.name)-附件"
                    info.type = 1
                    info.content = contractModel.appendiceList![0].componentPath
                    array1.append(info)
                }
                array.append(array1)
                
                if !(contractModel.accessoryBUrl?.isEmpty)! {
                    let info = ContractInfo()
                    info.title = "发送方采集视频"
                    info.thb = "\(contractModel.accessoryBUrl!)?vframe/jpg/offset/0"
                    info.type = 2
                    info.content = contractModel.accessoryBUrl!
                    array2.append(info)
                }
                
                if !(contractModel.accessoryCUrl?.isEmpty)! {
                    let info = ContractInfo()
                    info.title = "签署方采集视频"
                    info.thb = "\(contractModel.accessoryCUrl!)?vframe/jpg/offset/0"
                    info.type = 2
                    info.content = contractModel.accessoryCUrl!
                    array2.append(info)
                }
                array.append(array2)
                
                if !(contractModel.authorizationBUrl?.isEmpty)! {
                    let info = ContractInfo()
                    info.title = "发送方授权书"
                    info.type = 3
                    info.content = contractModel.authorizationBUrl!
                    array3.append(info)
                }
                
                if !(contractModel.authorizationCUrl?.isEmpty)! {
                    let info = ContractInfo()
                    info.title = "签署方授权书"
                    info.type = 3
                    info.content = contractModel.authorizationCUrl!
                    array3.append(info)
                }
                array.append(array3)
                
                for item in array {
                    if item.count > 0 {
                        self.contractInfos.append(item)
                    }
                }
                
                success(contractModel)
                self.tableView?.reloadData()
            } else if status == .dataError {
                SVProgressHUD.showError(withStatus: message)
            } else {
                self.tableView?.state(state: .networkFail)
            }
        }
    }
    
    //撤销合同
    func repealContract(model: ContractModel) {
        NetworkManager.shard.requestJSONDataWithTarget(target: ContractAPI.recallById(dataId: model.data_id)) { (status, result, message) in
            if status == .success {
                NotificationCenter.default.post(name: Notification.Name(rawValue: notification_refreshContract), object: nil, userInfo: ["index0": 5,"index1":7])
                
                NSObject.showAlertView(title: "撤销合同成功", message: nil, confirmTitle: "确定", confirmHandler: { (action) in
                    NSObject.currentNavigationController().popViewController(animated: true)
                })
            } else {
                SVProgressHUD.showError(withStatus: message)
            }
        }
    }
    
    //保全
    func preserveContract(model: ContractModel, isPreserve: Int) {
        let parameters = ["transmissionId": model.data_id, "isPreserve": isPreserve]
        NetworkManager.shard.requestJSONDataWithTarget(target: ContractAPI.preserveContract(parameters: parameters)) { (status, result, message) in
            if status == .success {
                guard let jsonDic = result!.dictionaryObject else { return }
                if isPreserve == 1 {
                    let isSuccess = jsonDic["isSuccess"] as! Int
                    if isSuccess == 1 {
                        SVProgressHUD.showSuccess(withStatus: "保全成功")
                    } else {
                        SVProgressHUD.showInfo(withStatus: "该合同已保全")
                    }
                }
            } else {
                SVProgressHUD.showError(withStatus: message)
            }
        }
    }
    
    func downloadFile(index: Int, model: ContractModel) {
        switch index {
        case 1: //发送方视频
            NetworkManager.shard.downloadFile(target: OtherAPI.downFile(downLoad: .video(url: model.accessoryBUrl!)), progress: { (progress) in
                SVProgressHUD.show(withStatus:"已下载\(Int(progress.progress * 100))%")
            }, download: { (path) in
                self.saveFile(path: path, isVideo: true)
            }) { (_) in }
        case 2: //签署方视频
            NetworkManager.shard.downloadFile(target: OtherAPI.downFile(downLoad: .video(url: model.accessoryCUrl!)), progress: { (progress) in
                SVProgressHUD.show(withStatus:"已下载\(Int(progress.progress * 100))%")
            }, download: { (path) in
                self.saveFile(path: path, isVideo: true)
            }) { (_) in }
        default: //合同
            NetworkManager.shard.downloadFile(target: OtherAPI.downFile(downLoad: .image(url: self.contractModel!.contractUrl!)), progress: { (progress) in
                SVProgressHUD.show(withStatus:"已下载\(Int(progress.progress * 100))%")
            }, download: { (path) in
                self.saveFile(path: path, isVideo: false)
            }) { (_) in }
        }
    }
}

extension ContractInfoViewModel {
    
    // MARK: Photos框架保存文件
    func saveFile(path: URL, isVideo: Bool) {
        PHPhotoLibrary.shared().performChanges({
            if isVideo {
                PHAssetChangeRequest.creationRequestForAssetFromVideo(atFileURL: path)
            } else {
                PHAssetChangeRequest.creationRequestForAssetFromImage(atFileURL: path)
            }
        }) { (isSuccess, error) in
            if isSuccess {
                SVProgressHUD.showSuccess(withStatus: "保存成功")
            } else {
                print("error---->\(String(describing: error))")
                SVProgressHUD.showError(withStatus: "保存失败")
            }
        }
    }
}
