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
        if !systemAuthority(type: type) {
            var title: String = "无法使用相机"
            if type == .audio {
                title = "无法使用麦克风"
            }
            NSObject.showAlertView(title: title, message: "请前往 [设置-隐私-相机-熊保宝] 打开访问权限", confirmTitle: "设置") { (action) in
                UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false], completionHandler: nil)
            }
            return false
        }
        return true
    }
       
    private static func systemAuthority(type: AVMediaType) -> Bool {
        let status = AVCaptureDevice.authorizationStatus(for: type)
        switch status {
        case .notDetermined:
            var temp: Bool = false
            AVCaptureDevice.requestAccess(for: type) { (granted) in
                if granted {//用户第一次同意了访问相机权限
                    temp = true
                }
            }
            return temp
        case .denied,.restricted:
            return false
        default:
            return true
        }
    }
}
