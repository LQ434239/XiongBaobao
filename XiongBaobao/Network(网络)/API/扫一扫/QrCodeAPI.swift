//
//  QrCodeAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/30.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

let QrCodelProvider = MoyaProvider<QrCodelAPI>()

enum QrCodelAPI {
    case bindRelation //绑定二维码
}

extension QrCodelAPI: TargetType {
    var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    var path: String {
        switch self {
        case .bindRelation:
            return kBindRelation
        }
    }
    
    var method: Moya.Method {
        return .post
    }
    
    var sampleData: Data {
        return "".data(using:.utf8)!
    }
    
    var task: Task {
        return .requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
