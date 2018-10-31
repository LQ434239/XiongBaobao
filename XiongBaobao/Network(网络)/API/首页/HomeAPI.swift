//
//  HomeAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation
import Moya

// 请求管理类
enum HomeAPI {
    case randVideo //随机视频
    case bannerList // 广告轮播
    case mallBanner // 商城图
    case notesInfo  //滚动文字
}

extension HomeAPI: TargetType {
    var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    var path: String {
        switch self {
        case .randVideo:
            return kRandVideo
        case .bannerList:
            return kBannerList
        case .mallBanner:
            return kBannerList
        case .notesInfo:
            return kNotesInfo
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using:.utf8)!
    }
    
    var task: Task {
        switch self {
        case .bannerList:
            return .requestParameters(parameters: ["queryType":"0"], encoding: URLEncoding.default)
        case .mallBanner:
            return .requestParameters(parameters: ["queryType":"1"], encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}

