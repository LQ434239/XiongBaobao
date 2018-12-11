//
//  InterfaceURL.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

//开发服务器：http://192.168.1.113:8012
//测试服务器：http://test.zfx99.com:8012
//回归服务器：http://47.96.93.150:8011
//生产服务器：https://zfx99.com


/*
 code    说明
 200     SUCCESS
 403     鉴权失败访问被拒绝
 404     资源不存在
 502     路径错误
 402     必填参数缺失
 401     其他错误
 406     字段非法
 405     用户不存在
 407     用户已冻结
 800     校验，业务处理出现异常--APP判断 code=800时拿出后端提示的msg提示框提示即可
 818     解除了B端权限"
 666     请登录--APP判断 code=666,跳到登录页面
 998     请求参数错误
 999     系统异常
 
 */

//服务器地址
let kBaseURL = "http://test.zfx99.com:8012"
//http://testxbb.qecity.com
let kMallBaseURL = "http://testxbb.qecity.com"

// MARK: 其他
/** 商城上传视频 */
let kMallUploadVideo = "/Cooperation/Cooperation/videoUpload"
/** 商城详情 */
let kMallDetail = "/Cooperation/Cooperation/shop_details"
/** 注册协议 */
let kRegistrationAgreement = "http://zfx.zfx99.com/Api/Index/registrationAgreement"
/** 查询最新版本信息 */
let kVersionSelect = "/api/version/select"

// MARK: 用户
/** 发送短信接口 */
let kSend = "/api/sms/send"
/** 用户注册 */
let kUserRegister = "/api/user/userRegister"
/** 用户登录 */
let kLogin = "/api/user/login"
/** 刷新用户信息 */
let kRefreshUserInfo = "/api/user/refreshUserInfo"
/** 设置密码 */
let kSetPassword = "/api/user/setPassword"
/** 修改密码接口 */
let kModifyPassword = "/api/user/modifyPassword"
/** 找回密码接口*/
let kForgotPassword = "/api/user/forgotPassword"
/** 设置用户信息 */
let kSetUserInfo = "/api/user/setUserInfo"
/** 获取用户头像 */
let kGetHeadImg = "/api/user/getHeadImg"
/** 上传凭证 */
let kUpToken = "/qiNiu/upToken"
/** 苹果支付 */
let kPayNotice = "/api/applepay/notice"
/** 创建预支付信息 */
let kUnifiedOrder = "/api/applepay/unifiedOrder"
/** 绑定极光 */
let kBindJPush = "/api/user/bindInfo"
/** 红点状态 */
let kRedDotState = "/api/user/redDotState"

// MARK: 首页
/** 首页广告列表 */
let kBannerList = "/api/advertisement/bannerList"
/** 随机视频 */
let kRandVideo = "/api/advertisement/randVideo"
/** 滚动信息 */
let kNotesInfo = "/api/advertisement/notesInfo"
/** 扫码绑定关系 */
let kBindRelation = "/api/qrcode/bindRelation"

// MARK: 个人中心
/** 我的消息列表 */
let kMessageList = "/api/msg/list"
/** 删除消息 */
let kDelMessage = "/api/msg/delMsg"
/** 阅读消息*/
let kReadMsg = "/api/msg/readMsg"
/** 提现申请 */
let kWithdrawApply = "/api/user/withdrawApply"
/** 提现信息 */
let kWithdrawInfo = "/api/user/withdrawInfo"
/** 我推荐的人的收入汇总 */
let kMyLowerIncomeList = "/api/user/myLowerIncomeList"
/** 我的提现记录 */
let kWithdrawRecordList = "/api/user/withdrawRecordList"
/** 生成个人二维码 */
let kGenerateQRcode = "/api/qrcode/generateQRcode"
/** 检查密码 */
let kCheckPassword = "/api/user/checkPassword"
/** 印章列表 */
let kSealList = "/api/user/sealList"
/** 添加印章 */
let kAddSeal = "/api/user/addSeal"
/** 删除印章 */
let kDelSeal = "/api/user/delSealById"
/** 编辑印章 */
let kEditSeal = "/api/user/editSeal"
/** 授权书列表 */
let kProxyBookList = "/api/user/proxyBookList"
/** 添加授权书 */
let kAddProxyBook = "/api/user/addProxyBook"
/** 删除授权书 */
let kDelProxyBook = "/api/user/delProxyBookById"
/** 编辑授权书 */
let kEditProxyBook = "/api/user/editProxyBook"
/** 教程 */
let kCourse = "/api/course"
/** 教程详情*/
let kCourseDetail = "/api/course/detail"

// MARK: 合同
/** 合同保全列表-B端 */
let kContractBList = "/api/contract/contractBList"
/** 合同保全列表-C端 */
let kContractCList = "/api/contract/contractCList"
/** 发送合同 */
let kSendContract = "/api/contract/sendContract"
/** 保全合同*/
let kPreserveContract = "/api/contract/preserveContract"
/** 签署合同 */
let kSignContract = "/api/contract/signContract"
/** 合同信息 */
let kContractById = "/api/contract/contractById"
/** 签署合同手写签名后完成后及时刷新合同信息 */
let kRefreshContractContent = "/api/contract/refreshContractContent"
/** 签名 */
let kSign = "/api/contract/sign"
/** 撤销合同 */
let kRecallById = "/api/contract/recallById"
/** 查看合同 */
let kViewContractById = "/api/contract/viewContractById"

// MARK: 保全
/** 保全总数统计 */
let kStatistics = "/api/preserve/statistics"
/** 申请出证 */
let kApplyCertificate = "/api/certificate/applyCertificate"
/** 已出证证书列表 */
let kCertificateList = "/api/certificate/certificateList"
/** 保全列表基础*/
let kBasicList = "/api/preserve/basicList"
/** 保全图片和视频名称修改 */
let kRename = "/api/preserve/rename"
/** 保全图片和视频 */
let kUploadImgAndVideo = "/api/preserve/uploadImgAndVideo"
