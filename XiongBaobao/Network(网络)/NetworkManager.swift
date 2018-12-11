//
//  NetworkManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/19.
//  Copyright © 2018年 双双. All rights reserved.
//

import Foundation
import Moya
import SwiftyJSON
import Result

// 成功
typealias SuccessBlock = (_ result: JSON) -> Void
// 失败
typealias FailureBlock = (_ failureMsg: String) -> Void
// 网络错误
typealias NetErrorBlock = (_ netError: String) -> Void
// 上传或下载进度
typealias ProgressBlock = (_ progress: ProgressResponse) -> Void
// 下载
typealias DownloadBlock = (_ path: String) -> Void

class NetworkManager {
    static let shard = NetworkManager()
    private let failureInfo = "数据解析失败"
    private let netError = "网络错误，请检查网络连接"
    
    // MARK: 请求JSON数据
    func requestJSONDataWithTarget<T: TargetType>(target: T, success: @escaping SuccessBlock, failure: @escaping FailureBlock, netError: @escaping NetErrorBlock) {
        let requestProvider = MoyaProvider<T>(endpointClosure: endpointClosure, requestClosure:requestTimeoutClosure(target: target))
        let _ = requestProvider.request(target) { (result) in
            self.dataTask(result, success: success, failure: failure, netError: netError)
        }
    }
    
    // MARK: 上传文件
    func uploadFile<T: TargetType>(target: T, progress: @escaping ProgressBlock, success: @escaping SuccessBlock, failure: @escaping FailureBlock, netError: @escaping NetErrorBlock) {
        let requestProvider = MoyaProvider<T>(endpointClosure: endpointClosure, requestClosure:requestTimeoutClosure(target: target))
        requestProvider.request(target, callbackQueue: .none, progress: { (uploadProgress: ProgressResponse) in
            progress(uploadProgress)
        }) { (result) in
            self.dataTask(result, success: success, failure: failure, netError: netError)
        }
    }
    
    // MARK: 下载文件
    func downloadFile<T: TargetType>(target: T, progress: @escaping ProgressBlock, download: @escaping DownloadBlock, failure: @escaping FailureBlock) {
        let requestProvider = MoyaProvider<T>(requestClosure:requestTimeoutClosure(target: target))
        requestProvider.request(target, callbackQueue: .none, progress: { (downloadProgress) in
            progress(downloadProgress)
        }) { (result) in
            switch result {
            case .success:
                download(DefaultDownloadDir.path)
            case let .failure(error):
                print("下载失败 = \(error.errorDescription!)")
                failure(error.errorDescription!)
            }
        }
    }
    
    // MARK: 统一处理数据
    private func dataTask(_ result: Result<Moya.Response, MoyaError>, success: @escaping SuccessBlock, failure: @escaping FailureBlock, netError: @escaping NetErrorBlock) {
        switch result {
        case let .success(response):
            do {
                let mapJson = try response.mapJSON()
                let json = JSON(mapJson)
                let code = json["code"].intValue
                let msg = json["msg"].stringValue
                let data = json["data"]
                guard let _ = json.dictionaryObject else {
                    print("msg = \(msg)")
                    return
                }
                if code == 200 {
                    success(data)
//                    NSLog(data)
                } else if (code == 666) {
                    //身份变更
                } else if (code == -1001) {
                    //请求超时
                } else {
                    print("msg = \(msg)")
                    failure(msg)
                }
            } catch {
                failure(self.failureInfo)
            }
        case let .failure(error):
            print("msg = \(error.errorDescription!)")
            netError(self.netError)
        }
    }
    
    // MARK: 设置请求超时时间
    private func requestTimeoutClosure<T: TargetType>(target: T) -> MoyaProvider<T>.RequestClosure {
        let requestTimeoutClosure = { (endpoint: Endpoint<T>, done: @escaping MoyaProvider<T>.RequestResultClosure) in
            do {
                var request = try endpoint.urlRequest()
                request.timeoutInterval = 15 //设置请求超时时间
//                request.cachePolicy = .reloadRevalidatingCacheData
                done(.success(request))
            } catch {
                return
            }
        }
        return requestTimeoutClosure
    }
    
    func endpointClosure<T: TargetType>(target: T) ->  Endpoint<T> {
        let url = target.baseURL.appendingPathComponent(target.path).absoluteString
        let endpoint = Endpoint<T>(url: url, sampleResponseClosure: { .networkResponse(200, target.sampleData) }, method: target.method, task: target.task, httpHeaderFields: target.headers)
//            if let accessToken = "" {
//                return endpoint.endpointByAddingHTTPHeaderFields(["access-token": accessToken])
//            } else {
//                return endpoint
//            }"accessToken": "331_9999_0f320b2459cb4d59a579d91b21e28de1"
        return endpoint.adding(newHTTPHeaderFields: ["accessToken": "331_9999_0f320b2459cb4d59a579d91b21e28de1"])
        
    }
}

