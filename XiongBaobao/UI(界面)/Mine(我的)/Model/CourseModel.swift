//
//  CourseModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/12.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class CourseModel: Mappable {
    
    var title: String?
    var createTime: String?
    var frontCoverPath: String?
    var dataId: Int?
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        title <- map["title"]
        createTime <- map["createTime"]
        frontCoverPath <- map["frontCoverPath"]
        dataId <- map["id"]
    }
}
