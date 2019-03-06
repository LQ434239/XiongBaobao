//
//  MineViewModel.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/12.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class MineViewModel: NSObject {

    var layouts = [[XBBLayoutModel]]()
    
    func loadLayout() {
        let titles = [["我的钱包"],["我的团队", "我的印章", "我的授权书", "在线教程"]]
        let subtitles = [["0熊币"], ["0人", "上传你的印章", "上传你的授权书", "有什么疑问点我哟"]]
        let classNames = [["XBBWalletViewController"],["XBBTeamViewController", "XBBSealOrProxyViewController", "XBBSealOrProxyViewController", "XBBCourseViewController"]]
        for i in 0..<titles.count {
            var array = [XBBLayoutModel]()
            for j in 0..<titles[i].count {
                let model = XBBLayoutModel()
                model.layout_type = (i == 1 && j == 1) ? 0: 1
                model.icon = "personal_szmm"
                model.title = titles[i][j]
                model.subtitle = subtitles[i][j]
                model.className = classNames[i][j]
                model.isHiddenLine = (i == 0) || (i == 1 && j == 3)
                array.append(model)
            }
            self.layouts.append(array)
        }
    }
}
