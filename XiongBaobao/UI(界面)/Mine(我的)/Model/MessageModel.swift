//
//  MessageModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/11.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class MessageModel: Mappable {
    var dataId: Int?
    var title: String?
    var content: String = "" //消息内容
    var contentStr: String {
        if self.category == 3 {
            return self.content
        }
        return self.content.removeHtmlLabel() 
    }
    var state: Int? //0:未读  1：已读
    
    var category: Int? //0:系统消息 1：支付消息 2：提现消息 3：合同消息
    var target: Int? //对象 0:普通用户 1：经销商 2：合伙人 3：服务中心
    var createTime: String? //创建日期
    
    required init?(map: Map) {}
    
    func mapping(map: Map) {
        dataId <- map["id"]
        title <- map["title"]
        content <- map["content"]
        category <- map["category"]
        target <- map["target"]
        createTime <- map["createTime"]
    }
}
