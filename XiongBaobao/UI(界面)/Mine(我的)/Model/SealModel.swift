//
//  SealModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/13.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class SealModel: Mappable {
    
    var dataId: Int?
    var sealName: String? //签章的名称
    var createTime: String?
    var sealPath: String? //路径
    var isSelected: Bool = false //是否选中
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        dataId <- map["id"]
        sealName <- map["sealName"]
        createTime <- map["createTime"]
        sealPath <- map["sealPath"]
    }
}
