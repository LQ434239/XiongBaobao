//
//  XBBLayoutModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//


class XBBLayoutModel: NSObject {
    
    var layout_type: Int? //布局类型
    var icon: String?
    var image: UIImage?
    var title: String? //标题
    var subtitle: String? //副标题
    var subText: String? //文本
    var className: String? //对应的控制器
    var isHiddenLine: Bool = false //是否隐藏线
    var isEnable: Bool = false //是否交互
}

