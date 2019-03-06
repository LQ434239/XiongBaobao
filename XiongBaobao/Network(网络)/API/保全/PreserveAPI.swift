//
//  PreserveAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

enum PreserveAPI {
    case statistics //保全统计
    case applyCertificate //申请出证
    case certificateList // 已出证证书列表
    case basicList(parameters: [String: Any])  //保全列表基础
    case rename  //保全图片和视频名称修改
    case uploadImg  //保全图片和视频
}

extension PreserveAPI: TargetType {
    var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    var path: String {
        switch self { 
        case .statistics:
            return kStatistics
        case .applyCertificate:
            return kApplyCertificate
        case .certificateList:
            return kCertificateList
        case .basicList:
            return kBasicList
        case .rename:
            return kRename
        case .uploadImg:
            return kUploadImgAndVideo
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .statistics,
             .certificateList, 
             .basicList:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using:.utf8)!
    }
    
    var task: Task {
        switch self {
        case .basicList(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        default:
            return Task.requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
