//
//  XBBShareSDKHelper.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/9.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

class XBBShareSDKHelper: NSObject {
    static let shard = XBBShareSDKHelper()
    
    override init() {
        super.init()
        WXApi.registerApp(kWeiXinAppID)
    }
    
    private func open(url: URL) -> Bool {
        return WXApi.handleOpen(url, delegate: self)
    }
    
    private func share(image: UIImage, scene: Int32) {
        if !WXApi.isWXAppInstalled() {
            SVProgressHUD.showError(withStatus: "未安装微信")
            return
        }
        let message = WXMediaMessage()
        //设置消息缩略图的方法
        message.setThumbImage(UIImage(named: "logo"))
        //多媒体消息中包含的图片数据对象
        let imageObject = WXImageObject()
        let data = image.pngData()
        imageObject.imageData = data
        //多媒体数据对象
        message.mediaObject = imageObject
        let req = SendMessageToWXReq()
        req.bText = false
        req.message = message
        req.scene = scene
        WXApi.send(req)
    }
}

extension XBBShareSDKHelper: WXApiDelegate {
    func onReq(_ req: BaseReq!) {
        print("onReq是微信终端向第三方程序发起请求，要求第三方程序响应。第三方程序响应完后必须调用sendRsp返回。在调用sendRsp返回时，会切回到微信终端程序界面")
    }
    
    func onResp(_ resp: BaseResp!) {
        if resp.isKind(of: SendMessageToWXResp.self) {
            switch resp.errCode { 
            case WXSuccess.rawValue:
                SVProgressHUD.showSuccess(withStatus: "分享成功")
            default:
                SVProgressHUD.showError(withStatus: "分享失败")
            }
        }
    }
}
