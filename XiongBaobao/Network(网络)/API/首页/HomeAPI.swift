//
//  HomeAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

// 请求管理类
enum HomeAPI {
    case bannerList // 广告轮播
}

extension HomeAPI: TargetType {
    var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    var path: String {
        return kBannerList
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var sampleData: Data {
        return "".data(using:.utf8)!
    }
    
    var task: Task {
        return .requestParameters(parameters: ["queryType":"0"], encoding: URLEncoding.default)
    }
    
    var headers: [String : String]? {
        return nil
    }
}

