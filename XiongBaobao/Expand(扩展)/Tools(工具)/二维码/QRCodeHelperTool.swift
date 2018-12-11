//
//  QRCodeHelperTool.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/9.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import AVFoundation

class QRCodeHelperTool: NSObject {
    
    //打开手电筒
    static func openFlashlight() {
        let device = AVCaptureDevice.default(for: .video)
        if (device?.hasTorch)! {
            let locked = try? device?.lockForConfiguration()
            if locked != nil {
                device?.torchMode = .on
                device?.unlockForConfiguration()
            }
        }
    }
    
    //关闭手电筒
    static func closeFlashlight() {
        let device = AVCaptureDevice.default(for: .video)
        if (device?.hasTorch)! {
          let locked = try? device?.lockForConfiguration()
            if locked != nil {
                device?.torchMode = .off
                device?.unlockForConfiguration()
            }
        }
    }
}
