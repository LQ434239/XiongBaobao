//
//  OtherAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation
import Moya

let OtherProvider = MoyaProvider<OtherAPI>()

fileprivate let fileName = ("\(Int32(Date().timeIntervalSince1970)).png")

enum OtherAPI {
    enum upload {
        case addSeal(file: URL, name: String, parameters: [String: Any])
        case addProxyBook(file: URL, name: String, parameters: [String: Any])
        case sendContract(file: URL, name: String, parameters: [String: Any])
        case signContract(file: URL, name: String, parameters: [String: Any])
        case sign(file: URL, name: String, parameters: [String: Any])
    }

    enum downLoad {
        case image(url: String)
        case video(url: String)
    }

    case uploadFile(upload: upload)
    case downFile(downLoad: downLoad)
}

extension OtherAPI: TargetType {
    var baseURL: URL {
        switch self {
        case .downFile(downLoad: .image), .downFile(downLoad: .video):
            return URL(string: "")!
        default:
            return URL(string: kBaseURL)!
        }
    }
    
    var path: String {
        switch self {
        case .uploadFile(.addSeal):
            return kAddSeal
        case .uploadFile(.addProxyBook):
            return kAddProxyBook
        case .uploadFile(.sendContract):
            return kSendContract
        case .uploadFile(.signContract):
            return kSignContract
        case .uploadFile(.sign):
            return kSign
        case .downFile(.image(let url)):
            return url
        case .downFile(.video(let url)):
            return url
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using:.utf8)!
    }
    
    var task: Task {
        switch self {
        case .uploadFile(.addSeal(let file, let name, let parameters)):
            let formData = MultipartFormData(provider: .file(file), name: name,
                                              fileName: fileName, mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case .uploadFile(.addProxyBook(let file, let name, let parameters)):
            let formData = MultipartFormData(provider: .file(file), name: name,
                                              fileName: fileName, mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case .uploadFile(.sendContract(let file, let name, let parameters)):
            let formData = MultipartFormData(provider: .file(file), name: name,
                                              fileName: fileName, mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case .uploadFile(.signContract(let file, let name, let parameters)):
            let formData = MultipartFormData(provider: .file(file), name: name,
                                              fileName: fileName, mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case .uploadFile(.sign(let file, let name, let parameters)):
            let formData = MultipartFormData(provider: .file(file), name: name,
                                              fileName: fileName, mimeType: "image/png")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case .downFile(.image):
            return .downloadDestination(DefaultDownloadDestination)
        case .downFile(.video):
            return .downloadDestination(DefaultDownloadDestination)
        }
    }
    
    var headers: [String : String]? {
        //["Content-Type": "application/json", "charset":"utf-8"]
        //return ["Content-Type": "application/json"]
        return nil
    }
}

//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
    return (DefaultDownloadDir.appendingPathComponent(response.suggestedFilename!), [])
}

//默认下载保存地址
let DefaultDownloadDir: URL = {
    //documentDirectory 
    let directoryURLs = FileManager.default.urls(for: .cachesDirectory,
                                                 in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()
