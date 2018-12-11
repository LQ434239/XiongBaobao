//
//  UserManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/2.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

class UserManager {
    
    private var user: UserInfo?
    
    static let shard = UserManager()
    
    func save(user: UserInfo) {
        self.user = user
    }
    
    func read() -> UserInfo {
        return self.user!
    }
    
    func logout() {
        self.user = nil
        UserDefaults.standard.removeObject(forKey: "isB")
        UserDefaults.standard.removeObject(forKey: "accessToken")
    }
}
