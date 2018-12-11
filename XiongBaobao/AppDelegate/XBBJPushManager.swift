//
//  XBBJPushManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/9.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation
import UserNotifications

class XBBJPushManager: NSObject {
    static let shard = XBBJPushManager()
    
    override init() {
        super.init()
        NotificationCenter.default.addObserver(self, selector: #selector(networkDidReceiveMessage), name: NSNotification.Name.jpfNetworkDidReceiveMessage, object: nil)
    }
}

extension XBBJPushManager {
    @objc func networkDidReceiveMessage(notification: [String : Any]) {
        
    }
    
    //注册极光
    private func JPushRegister(launchOptions: [String : Any]) {
        JPUSHService.setup(withOption: launchOptions,
                           appKey: kJPushAppKey,
                           channel: "App Store",
                           apsForProduction: false)
        let entity = JPUSHRegisterEntity.init()
        entity.types = Int(JPAuthorizationOptions.badge.rawValue)
        JPUSHService.register(forRemoteNotificationConfig: entity, delegate: self)
    }
    
    //统一处理接收通知的处理
    private func didReceiveJPush(notification: [String : Int]) {
        let type = notification["type"]
        switch UIApplication.shared.applicationState {
        case .active:
            print("前台收到消息")
        case .inactive:
            print("点击推送弹出的通知")
            if !((type == 665) &&
                (type == 818))  {
                handleMessage(notification: notification)
            }
        case .background:
            print("后台收到消息")
        }
    }
    
    //消息类型
    private func handleMessage(notification: [String : Int]) {
        
    }
}

extension XBBJPushManager: JPUSHRegisterDelegate {
    // iOS 10中收到推送消息
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, willPresent notification: UNNotification!, withCompletionHandler completionHandler: ((Int) -> Void)!) {
        let userInfo = notification.request.content.userInfo
        if (notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            JPUSHService.handleRemoteNotification(userInfo)
            print("iOS10前台收到远程通知:\(userInfo)")
        } else {
            print("iOS10前台收到本地通知:\(userInfo)")
        }
        completionHandler(Int(UNNotificationPresentationOptions.badge.rawValue))
    }
    
    // 通过点击推送弹出的通知调用,包括前台和后台(didReceiveNotificationResponse)
    func jpushNotificationCenter(_ center: UNUserNotificationCenter!, didReceive response: UNNotificationResponse!, withCompletionHandler completionHandler: (() -> Void)!) {
        let userInfo = response.notification.request.content.userInfo
        if (response.notification.request.trigger?.isKind(of: UNPushNotificationTrigger.self))! {
            JPUSHService.handleRemoteNotification(userInfo)
            print("收到远程通知:\(userInfo)")
            didReceiveJPush(notification: userInfo as! [String : Int])
        } else {
            print("前台收到本地通知:\(userInfo)")
        }
        completionHandler()
    }
}
