//
//  ContractAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation
import Moya

enum ContractAPI {
    case contractList //合同列表
    case sendContract //发送合同
    case preserveContract //保全合同
    case signContract  //签署合同
    case contractById  //合同信息
    case refreshContract  //签署合同手写签名后完成后及时刷新合同信息
    case sign  //签名
    case recallById  //撤销合同
    case viewContractById  //查看合同
}

extension ContractAPI: TargetType {
    var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    var path: String {
        switch self {
        case .contractList:
            return kContractBList
        case .sendContract:
            return kSendContract
        case .preserveContract:
            return kPreserveContract
        case .signContract:
            return kSignContract
        case .contractById:
            return kContractById
        case .refreshContract:
            return kRefreshContractContent
        case .sign:
            return kSign
        case .recallById:
            return kRecallById
        case .viewContractById:
            return kViewContractById
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .contractList, .contractById, .viewContractById:
            return .get
        default:
            return .post
        }
    }
    
    var sampleData: Data {
        return "".data(using:.utf8)!
    }
    
    var task: Task {
        return Task.requestPlain
    }
    
    var headers: [String : String]? {
        return nil
    }
}
