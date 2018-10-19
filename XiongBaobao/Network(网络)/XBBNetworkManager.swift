//
//  XBBNetworkManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/18.
//  Copyright © 2018年 双双. All rights reserved.
//

import Foundation

var _manager = AFHTTPSessionManager()

class XBBNetworkManager {
    // 共享实例
    static let shared = XBBNetworkManager()
    func sessionManager() {
        _manager.requestSerializer = AFHTTPRequestSerializer()
        _manager.requestSerializer.timeoutInterval = 15.0
        _manager.responseSerializer = AFJSONResponseSerializer()
        
    }
    
    init() {
        
    }
}
