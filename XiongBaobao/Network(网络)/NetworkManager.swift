//
//  NetworkManager.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/19.
//  Copyright © 2018年 双双. All rights reserved.
//

import Foundation
import SwiftyJSON
import Result

enum RespondStatus {
    case success
    case dataError
    case netError
}

// 失败
typealias FailureBlock = (_ failureMsg: String) -> Void
// 上传或下载进度
typealias ProgressBlock = (_ progress: ProgressResponse) -> Void
// 下载
typealias DownloadBlock = (_ path: URL) -> Void
//数据响应
typealias RespondBlock = (_ status: RespondStatus, _ result: JSON?,_ message: String?) -> Void

class NetworkManager {
    static let shard = NetworkManager()
    private let failureInfo = "数据解析失败"
    private let netError = "网络错误，请检查网络连接"
    
    // MARK: 请求JSON数据
    func requestJSONDataWithTarget<T: TargetType>(target: T, respondBlock: @escaping RespondBlock) {
        let requestProvider = MoyaProvider<T>(endpointClosure: endpointClosure, requestClosure:requestTimeoutClosure(target: target))
        let _ = requestProvider.request(target) { (result) in
            self.dataTask(result, respondBlock: respondBlock) 
        }
    }
    
    // MARK: 上传文件
    func uploadFile<T: TargetType>(target: T, progress: @escaping ProgressBlock, respondBlock: @escaping RespondBlock, failure: @escaping FailureBlock) {
        let requestProvider = MoyaProvider<T>(endpointClosure: endpointClosure, requestClosure:requestTimeoutClosure(target: target))
        requestProvider.request(target, callbackQueue: .none, progress: { (uploadProgress: ProgressResponse) in
            progress(uploadProgress)
        }) { (result) in
            self.dataTask(result, respondBlock: respondBlock)
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
                let localLocation = DefaultDownloadDir.appendingPathComponent(fileName)
                download(localLocation)
            case let .failure(error):
                print("下载失败 = \(error.errorDescription!)")
                SVProgressHUD.showError(withStatus: "下载失败")
                failure(error.errorDescription!)
            }
        }
    }
    
    // MARK: 请求JSON数据
    private func dataTask(_ result: Result<Moya.Response, MoyaError>, respondBlock: RespondBlock) {
        switch result {
        case let .success(response):
            do {
                let mapJson = try response.mapJSON()
                let json = JSON(mapJson)
                let code = json["code"].intValue
                let msg = json["msg"].stringValue
                let data = json["data"]
                guard let _ = json.dictionaryObject else { return }
                if code == 200 {
                    respondBlock(.success, data, nil)
                } else if (code == 666) {
                    //身份变更
                } else if (code == -1001) {
                    //请求超时
                } else {
                    print("msg = \(msg)")
                    respondBlock(.dataError, nil, msg)
                }
            } catch {
                respondBlock(.dataError, nil, self.failureInfo)
            }
        case let .failure(error):
            print("msg = \(error.errorDescription!)")
            respondBlock(.netError, nil, self.netError)
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
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            return endpoint.adding(newHTTPHeaderFields: ["accessToken": accessToken])
        } else {
            return endpoint
        }
//        return endpoint.adding(newHTTPHeaderFields: ["accessToken": "57_9999_93cbda2f42a14e44a7a144601d9ea85a"])
    }
}

