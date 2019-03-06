//
//  ProxyModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/13.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class ProxyModel: Mappable {
    var dataId: Int?
    var certificateName: String? //公司名称
    var createTime: String?
    var certificatePath: String? //路径
    var isSelected: Bool = false //是否选中
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        dataId <- map["id"]
        certificateName <- map["certificateName"]
        createTime <- map["createTime"]
        certificatePath <- map["certificatePath"]
    }
}
