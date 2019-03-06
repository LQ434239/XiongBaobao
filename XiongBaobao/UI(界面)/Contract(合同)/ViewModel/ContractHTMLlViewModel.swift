//
//  ContractHTMLlViewModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/6.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class ContractHTMLlViewModel: NSObject {

    //加载合同
    func loadContract(model: ContractModel, success: @escaping (_ model: ContractModel) -> Void) {
        
        let parameters = ["transmissionId": model.dataId, "state": model.status!]
        NetworkManager.shard.requestJSONDataWithTarget(target: ContractAPI.contractById(parameters: parameters)) { (status, result, message) in
            if status == .success {
                guard let jsonDic = result!.dictionaryObject else { return }
                let contractModel = ContractModel(JSON: jsonDic)!
                success(contractModel)
            }
        }
    }
    
    //上传签名
    func upload(signature: UIImage) {
//        NetworkManager.shard.requestJSONDataWithTarget(target: OtherAPI.uploadFile(upload: .sign(image:signature , parameters: ["file": signature]))) { (status, result, message) in
//
//        }
    }
    
    //刷新合同
    func refreshContract(model: ContractModel, success: @escaping (_ model: ContractModel) -> Void) {
        
    }
}
