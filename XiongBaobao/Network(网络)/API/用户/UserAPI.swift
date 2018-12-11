//
//  UserAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

enum UserAPI {
    case send //发送短信接口
    case userRegister //用户注册
    case login //用户登录
    case refreshUserInfo  //刷新用户信息
    case setPassword  //设置密码
    case modifyPassword  //修改密码接口
    case forgotPassword  //找回密码接口
    case setUserInfo  //设置用户信息
    case getHeadImg  //获取用户头像
    case qiNiuUpToken  //获取七牛token
    case payNotice(receiptData: String, outTradeNo: String)  //苹果支付
    case unifiedOrder(amount: CGFloat)  //创建预支付信息
    case versionSelect  //版本查询
    case checkPassword  //检查密码
    case bindJPush  //绑定极光
    case redDotState  //获取红点状态
}

extension UserAPI: TargetType {
    var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    var path: String {
        switch self {
        case .send:
            return kSend
        case .userRegister:
            return kUserRegister
        case .login:
            return kLogin
        case .refreshUserInfo:
            return kRefreshUserInfo
        case .setPassword:
            return kSetPassword
        case .modifyPassword:
            return kModifyPassword
        case .forgotPassword:
            return kForgotPassword
        case .setUserInfo:
            return kSetUserInfo
        case .getHeadImg:
            return kGetHeadImg
        case .qiNiuUpToken:
            return kUpToken
        case .payNotice:
            return kPayNotice
        case .unifiedOrder:
            return kUnifiedOrder
        case .versionSelect:
            return kVersionSelect
        case .checkPassword:
            return kCheckPassword
        case .bindJPush:
            return kBindJPush
        case .redDotState:
            return kRedDotState
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getHeadImg,
             .qiNiuUpToken,
             .unifiedOrder,
             .versionSelect,
             .redDotState:
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
        case .versionSelect:
            return .requestParameters(parameters: ["category":"1"], encoding: URLEncoding.default)
        case .unifiedOrder(let amount):
            return .requestParameters(parameters: ["amount":amount], encoding: URLEncoding.default)
        case .payNotice(let receiptData, let outTradeNo):
            let params = ["receiptData":receiptData, "outTradeNo":outTradeNo]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        case .login: //13333333333
            let params = ["userName":"13333333333",
                "password":"",
                "verificationCode":"888888",
                "deviceId":kUUID,
                "deviceType":"ios"]
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return nil
    }
}
