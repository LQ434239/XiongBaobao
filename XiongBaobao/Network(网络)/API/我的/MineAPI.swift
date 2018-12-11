//
//  MineAPI.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/26.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

enum MineAPI {
    case messageList //消息列表
    case delMessage //删除消息
    case readMsg //阅读消息
    case generateQRcode  //生成个人二维码
    case myLowerIncomeList  //我推荐的人的收入汇总
    case withdrawInfo  //提现信息
    case withdrawApply  //提现申请
    case withdrawRecordList  //提现记录
    case sealList  //印章列表
    case addSeal  //添加印章
    case editSeal  //编辑印章
    case proxyBookList  //授权书列表
    case addProxyBook  //添加授权书
    case course  //教程
    case courseDetail  //教程详情
}

extension MineAPI: TargetType {
    var baseURL: URL {
        return URL(string: kBaseURL)!
    }
    
    var path: String {
        switch self {
        case .messageList:
            return kMessageList
        case .delMessage:
            return kDelMessage
        case .readMsg:
            return kReadMsg
        case .generateQRcode:
            return kGenerateQRcode
        case .myLowerIncomeList:
            return kMyLowerIncomeList
        case .withdrawInfo:
            return kWithdrawInfo
        case .withdrawApply:
            return kWithdrawApply
        case .withdrawRecordList:
            return kWithdrawRecordList
        case .sealList:
            return kSealList
        case .addSeal:
            return kAddSeal
        case .editSeal:
            return kEditSeal
        case .proxyBookList:
            return kProxyBookList
        case .addProxyBook:
            return kAddProxyBook
        case .course:
            return kCourse
        case .courseDetail:
            return kCourseDetail
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .delMessage,
             .readMsg,
             .withdrawApply:
            return .post
        default:
            return .get
        }
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
