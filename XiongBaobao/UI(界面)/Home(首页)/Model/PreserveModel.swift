//
//  PreserveModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/14.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class PreserveModel: Mappable {
    var securityId: Int?
    var createDate: String?
    var fileName: String = ""
    var certificateNumber: String? //证书编号
    var certificateUrl: String? //证书url
    var fileUrl: String = "" //文件url
    var thumbnail: String? {
        return self.type == 0 ? "\(self.fileUrl)?vframe/jpg/offset/0": "\(self.fileUrl)?imageView2/1/w/60/h/60"
    }
    var fileSize: Float = 0
    var size: String? {
        return  String(format: "%.2fM", self.fileSize / 1024.0 / 1024.0)
    }
    var type: Int? //文件类型 0：图片 1：视频 2：文本 3：其它
    
    required init?(map: Map) { }
    
    func mapping(map: Map) {
        securityId <- map["securityId"]
        createDate <- map["createDate"]
        fileName <- map["fileName"]
        certificateNumber <- map["certificateNumber"]
        certificateUrl <- map["certificateUrl"]
        fileUrl <- map["fileUrl"]
        fileSize <- map["fileSize"]
        type <- map["type"]
    }
}
