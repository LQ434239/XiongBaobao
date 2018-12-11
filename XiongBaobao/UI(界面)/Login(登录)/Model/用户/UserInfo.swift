//
//  UserInfo.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/2.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation
import ObjectMapper

class UserInfo: Mappable {
    let rankNames: Array = ["","经销商","经销商","服务中心"]
    let flRankNames: Array = ["--","经销商","合伙人","合伙人"]
    
    var userName: String = ""  //用户名
    var accessToken: String = ""
    var phoneNumber: String = ""  //手机号
    var flPhoneNumber: String = ""  //上级电话
    var qinNiuDomain: String = ""  //七牛空间domain
    var flUserName: String = ""  //上级昵称
    var withdrawNotes: String = "" //提现说明
    var headImg: String = ""  //用户头像
    var isB: Int = 0  //是否是B端用户
    var userSex: Int = 0  //性别
    var isSetPsw: Int = 0  //密码是否设置
    var preserveUnitprice: Int = 1  //保全单价
    var rank: Int = 0  //级别0:普通用户 1：经销商 2：合伙人 3：服务中心
    var flRank: Int = 0  //上级级别0:普通用户 1：经销商 2：合伙人 3：服务中心

    var flPhone: String {
        get {
            if flPhoneNumber.count > 11 {
                return flPhoneNumber
            }
            let ns3 = (flPhoneNumber as NSString).substring(with: NSMakeRange(3, 4))
            return flPhoneNumber.replacingOccurrences(of: ns3, with: "****")
        }
    }
    
    var rankName: String {
        get {
            return rankNames[rank]
        }
    }
    
    var flRankName: String {
        get {
            return flRankNames[flRank]
        }
    }
    
    var flName: String {
        get {
            return flUserName.isPhoneNumber() ? flPhone: flUserName
        }
    }
   
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        userName <- map["userName"]
        accessToken <- map["accessToken"]
        phoneNumber <- map["phoneNumber"]
        flPhoneNumber <- map["flPhoneNumber"]
        qinNiuDomain <- map["qinNiuDomain"]
        flUserName <- map["flUserName"]
        withdrawNotes <- map["withdrawNotes"]
        headImg <- map["headImg"]
        isB <- map["isB"]
        userSex <- map["userName"]
        isSetPsw <- map["accessToken"]
        preserveUnitprice <- map["phoneNumber"]
        rank <- map["rank"]
        flRank <- map["flRank"]
    }
}
