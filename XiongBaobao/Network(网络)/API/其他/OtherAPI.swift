//
//  OtherAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

let OtherProvider = MoyaProvider<OtherAPI>()

let fileName = ("\(kTimeStamp).mp4")

enum OtherAPI {
    enum upload {
        case addSeal(image: UIImage, parameters: [String: Any])
        case addProxyBook(image: UIImage, parameters: [String: Any])
        case sendContract(file: URL, parameters: [String: Any])
        case signContract(file: URL, parameters: [String: Any])
        case sign(image: UIImage, parameters: [String: Any])
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
        case .downFile(.image(let url)):
            return URL(string: url)!
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
        case .downFile:
            return ""
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
        case let .uploadFile(.addSeal(image, parameters)):
            return .uploadCompositeMultipart([multipartFormData(image, "sealFile")], urlParameters: parameters)
        case let .uploadFile(.addProxyBook(image, parameters)):
            return .uploadCompositeMultipart([multipartFormData(image, "proxyFile")], urlParameters: parameters)
        case let .uploadFile(.sendContract(file, parameters)):
            let formData = MultipartFormData(provider: .file(file), name: "file",
                                              fileName: fileName, mimeType: "mp4")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case let .uploadFile(.signContract(file, parameters)):
            let formData = MultipartFormData(provider: .file(file), name: "file",
                                              fileName: fileName, mimeType: "mp4")
            return .uploadCompositeMultipart([formData], urlParameters: parameters)
        case let .uploadFile(.sign(image, parameters)):
            return .uploadCompositeMultipart([multipartFormData(image, "file")], urlParameters: parameters)
        case .downFile(.image):
            return .downloadDestination(DefaultDownloadDestination)
        case .downFile(.video):
            return .downloadDestination(DefaultDownloadDestination)
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

//表示上传的数据
func multipartFormData(_ image: UIImage, _ name: String) -> MultipartFormData{
    let formData = MultipartFormData(provider: .data(image.compress()), name: name,
                                     fileName: fileName, mimeType: "image/png")
    return formData
}

//定义下载的DownloadDestination（不改变文件名，同名文件不会覆盖）
private let DefaultDownloadDestination: DownloadDestination = { temporaryURL, response in
//    response.suggestedFilename!
    return (DefaultDownloadDir.appendingPathComponent(fileName), [.removePreviousFile])
}

//默认下载保存地址
let DefaultDownloadDir: URL = {
    let directoryURLs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    return directoryURLs.first ?? URL(fileURLWithPath: NSTemporaryDirectory())
}()

