//
//  JudgeAuthority.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/28.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

extension NSObject {
    
    //验证权限
    static func judgeSystemAuthority(type: AVMediaType) -> Bool {
        var temp = true
        var title: String = "相机"
        if type == .audio {
            title = "麦克风"
        }
        let status = AVCaptureDevice.authorizationStatus(for: type)
        if status == .denied || status == .restricted {
            temp = false
            NSObject.showAlertView(title: "无法使用" + title, message: "请前往 [设置-隐私-\(title)] 打开访问权限", cancelTitle: "取消", confirmTitle: "设置") { (action) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false], completionHandler: nil)
            }
        }
        if status == .notDetermined {
            AVCaptureDevice.requestAccess(for: type) { (granted) in
                if !granted { //用户第一次是否同意访问相机权限
                    NSObject.showAlertView(title: title, message: "请前往 [设置-隐私-\(title)] 打开访问权限", confirmTitle: "设置", confirmHandler: { (action) in
                       UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false], completionHandler: nil)
                    })
                }
            }
        }
        return temp
    }
}
