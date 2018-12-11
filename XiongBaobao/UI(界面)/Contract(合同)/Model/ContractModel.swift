//
//  XBBContractModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/29.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

//参数列表
class ContractParaModel: Mappable {
    var data_id: Int?
    var bgColor: String? //色标
    var parameterName: String? //参数名称
    var parameterPosition: String? //坐标
    var parameterValue: String? //参数值
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        data_id <- map["id"]
        parameterName <- map["parameterName"]
        parameterPosition <- map["parameterPosition"]
        parameterValue <- map["parameterValue"]
    }
}

//附件列表
class AppendiceModel: Mappable {
    var data_id: Int?
    var componentName: String? //名称
    var componentPath: String? //附件路径
    var createTime: String? //创建日期
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        data_id <- map["id"]
        componentName <- map["componentName"]
        componentPath <- map["componentPath"]
        createTime <- map["createTime"]
    }
}

class XBBContractModel: Mappable {
    var data_id: Int = 0
    var merchantId: Int? //发送方ID
    var signId: Int? //签署方ID
    var status: Int? //合同状态：0：待审核 1：待我签署 2：待TA签署 3：待发送 4：已完成 5：已拒签 6：已失效
    var isViewed: Int = 0 //是否查看0：未查看 1：已查看
    var name: String = "" //合同标题
    var phoneNumber: String?  //签署方手机号码
    var refuseTime: String? //拒签时间
    var sendTime: String?  //发送时间
    var merchantName: String?  //发送方名称
//    var commonName: String?  //签署方或者发送方
    var signName: String?  //签署方名称
    var completeTime: String?  //完成时间
    var statusName: String { //状态名称
        return statusNames[status!]
    }
    
    var time: String { //统一时间
        return (status == 5 ? refuseTime: status == 4 ? completeTime: status == 3 ? "": sendTime)!
    }
    var merchantPhoneNumber: String?  //发送方公司电话
    var certificateNumber: String?  //证书编号
    var refusalReason: String?  //拒签理由
    var accessoryBUrl: String?  //B端视频
    var accessoryCUrl: String?  //C端视频
    var authorizationBUrl: String?  //B端授权书
    var authorizationCUrl: String?  //C端授权书
    var downloadUrl: String?  //zip下载链接
    var contractUrl: String?  //合同PNG下载的url
    var content: String?  //HTML
    var statusColor: UIColor?  //状态颜色
    var paraList: [ContractParaModel]?
    var appendiceList: [AppendiceModel]?
    
    var statusNames: [String] {
        return ["待审核","待我签署","待TA签署","待发送","已完成","已拒签","已失效"]
    }

    required init?(map: Map) { }
    
    func mapping(map: Map) {
        data_id <- map["id"]
        merchantId <- map["createTime"]
        signId <- map["signId"]
        isViewed <- map["isViewed"]
        name <- map["name"]
        status <- map["state"]
        phoneNumber <- map["phoneNumber"]
        refuseTime <- map["refuseTime"]
        sendTime <- map["sendTime"]
        merchantName <- map["merchantName"]
        signName <- map["signName"]
        completeTime <- map["completeTime"]
        merchantPhoneNumber <- map["merchantPhoneNumber"]
        certificateNumber <- map["certificateNumber"]
        refusalReason <- map["refusalReason"]
        accessoryBUrl <- map["accessoryBUrl"]
        accessoryCUrl <- map["accessoryCUrl"]
        authorizationBUrl <- map["authorizationBUrl"]
        authorizationCUrl <- map["authorizationCUrl"]
        downloadUrl <- map["downloadUrl"]
        contractUrl <- map["contractUrl"]
        content <- map["content"]
        paraList <- map["paraList"]
        appendiceList <- map["appendiceList"]
    }
}
