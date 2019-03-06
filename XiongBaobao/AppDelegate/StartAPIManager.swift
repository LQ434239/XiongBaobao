//
//  StartAPIManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class VersionModel: Mappable {
    var notify: Bool = true
    var remark: String?
    var version: String?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        notify <- map["notify"]
        remark <- map["remark"]
        version <- map["version"]
    }
}

class StartAPIManager: NSObject {

    static func xbb_setLaunchOption() {
        xbb_versionSelect()
//        refreshUserInfo()
        xbb_login()
    }
    
    static private func xbb_versionSelect() {
        NetworkManager.shard.requestJSONDataWithTarget(target: UserAPI.versionSelect) { (status, result, message) in
            if status == .success {
                guard let jsonDict = result!.dictionaryObject else { return }
                let model: VersionModel = VersionModel(JSON: jsonDict)!
                
                if model.notify && (model.version!.versionCompare() == .bigger) {
                    
                }
            }
        }
    }
    
    static private func xbb_refreshUserInfo() {
        NetworkManager.shard.requestJSONDataWithTarget(target: UserAPI.refreshUserInfo) { (status, result, message) in
            if status == .success {
                guard let jsonDict = result!.dictionaryObject else { return }
                let model: UserInfo = UserInfo(JSON: jsonDict)!
                
                UserManager.shard.save(user: model)
                
                UserDefaults.standard.set(model.isB, forKey: "isB")
                UserDefaults.standard.set(model.accessToken, forKey: "accessToken")
            }
        }
    }
    
    static private func xbb_login() {
        NetworkManager.shard.requestJSONDataWithTarget(target: UserAPI.login) { (status, result, message) in
            if status == .success {
                guard let jsonDict = result!.dictionaryObject else { return }
                let model: UserInfo = UserInfo(JSON: jsonDict)!
                
                UserManager.shard.save(user: model)
                
                UserDefaults.standard.set(model.isB, forKey: "isB")
                UserDefaults.standard.set(model.accessToken, forKey: "accessToken")
            }
        }
    }
}
