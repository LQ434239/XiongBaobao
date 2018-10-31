//
//  CacheManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/19.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit
import Cache

enum XBBExpiry {
    // 对象将在最近的将来过期(不过期)
    case never
    // 对象将在指定的秒数内过期
    case seconds(TimeInterval)
    // 对象将在指定日期过期
    case date(Date)
    
    //返回适当的date对象
    public var expiry: Expiry {
        switch self {
        case .never:
            return Expiry.never
        case .seconds(let seconds):
            return Expiry.seconds(seconds)
        case .date(let date):
            return Expiry.date(date)
        }
    }
    public var isExpired: Bool {
        return expiry.isExpired
    }
}

struct CacheModel: Codable {
    var data: Data?
    var dataDict: Dictionary<String, Data>?
    init() {}
}

class CacheManager: NSObject {
    static let `default` = CacheManager()
    private var storage: Storage<CacheModel>?
    override init() {
        super.init()
        expiryConfiguration()
    }
    var expiry: XBBExpiry = .never
    
    func expiryConfiguration(expiry: XBBExpiry = .never) {
        self.expiry = expiry
        //设置磁盘存储
        let diskConfig = DiskConfig(
            name: "CacheName",
            expiry: expiry.expiry
        )
        //通过MemoryConfig来将内存作为前端存储
        let memoryConfig = MemoryConfig(expiry: expiry.expiry)
        do {
            //在从存储中加载时，可能会出现磁盘问题或类型不匹配的错误
            try storage = Storage(diskConfig: diskConfig, memoryConfig: memoryConfig, transformer: TransformerFactory.forCodable(ofType: CacheModel.self))
        } catch {
            NSLog(error)
        }
    }
    
    // 清除所有缓存
    func removeAllCache(completion: @escaping (_ isSuccess: Bool)->()) {
        storage?.async.removeAll(completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    
    // 根据key值清除缓存
    func removeObjectCache(_ cacheKey: String, completion: @escaping (_ isSuccess: Bool)->()) {
        storage?.async.removeObject(forKey: cacheKey, completion: { result in
            DispatchQueue.main.async {
                switch result {
                case .value: completion(true)
                case .error: completion(false)
                }
            }
        })
    }
    
    // 读取缓存
    func cacheForKey(_ key: String) -> CacheModel? {
        do {
            //过期清除缓存
            if let isExpire = try storage?.isExpiredObject(forKey: key), isExpire {
                removeObjectCache(key) { (_) in }
                return nil
            } else {
                return (try storage?.object(forKey: key)) ?? nil
            }
        } catch {
            return nil
        }
    }
    
    // 异步缓存
    func setObject(_ object: CacheModel, forKey key: String) {
        storage?.async.setObject(object, forKey: key, expiry: nil, completion: { (result) in
            switch result {
            case .value(_):
                NSLog("缓存成功")
            case .error(let error):
                NSLog("缓存失败: \(error)")
            }
        })
    }
}
