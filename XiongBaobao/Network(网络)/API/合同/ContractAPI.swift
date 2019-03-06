//
//  ContractAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

enum ContractAPI {
    case contractList(isProxyC: Bool, parameters: [String: Any]) //合同列表
    case sendContract //发送合同
    case preserveContract(parameters: [String: Int]) //保全合同
    case signContract  //签署合同
    case contractById(parameters: [String: Any])  //合同信息
    case refreshContract  //签署合同手写签名后完成后及时刷新合同信息
    case recallById(dataId: Int)  //撤销合同
    case viewContractById  //查看合同
}

extension ContractAPI: TargetType {
    var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    var path: String {
        switch self {
        case .contractList(let isProxyC, _):
            return isProxyC ? kContractBList: kContractCList
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
        switch self {
        case .contractList(_, let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .contractById(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        case .recallById(let dataId):
            return .requestParameters(parameters: ["transmissionId": dataId], encoding: URLEncoding.default)
        case .preserveContract(let parameters):
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
