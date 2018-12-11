//
//  ApplePay.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/8.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import StoreKit


typealias PaySuccessBlock = () -> Void

class ApplePay: NSObject {
    
    var productName: String = ""
    var orderId: String = ""
    
    var paySuccess: PaySuccessBlock?
    
    static let shard = ApplePay()
    
    override init() {
        //添加一个支付队列观察者
        SKPaymentQueue.default().add(ApplePay.shard)
    }
}

extension ApplePay {
    func createOrder(price: CGFloat) {
        self.productName = "com.ZFXData.Pandababy.Money.\(price)"
        SVProgressHUD.show(withStatus: "请稍等")
        NetworkManager.shard.requestJSONDataWithTarget(target: UserAPI.unifiedOrder(amount: price * 100)) { (status, result, message) in
            if status == .success {
                guard let jsonDict = result!.string else { return }
                self.orderId = jsonDict
            } else if status == .dataError {
                SVProgressHUD.showError(withStatus: message)
            } else {
                SVProgressHUD.dismiss()
                NSObject.currentController().view.makeToast(message)
            }
        }
    }
    
    private func requestPayWithProductName(productName: String) {
        if SKPaymentQueue.canMakePayments() {
            let set = NSSet(array: [productName])
            let request = SKProductsRequest(productIdentifiers: set as! Set<String>)
            request.delegate = self
            request.start()
        } else {
            SVProgressHUD.dismiss()
            NSObject.showAlertView(title: "提示", message: "请到“设置-通用-访问限制”内，开启App内购买项目功能", confirmTitle: "好") { (alert) in }
        }
    }
}

extension ApplePay: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        if response.products.count == 0 {
            SVProgressHUD.showInfo(withStatus: "暂无商品")
            return
        }
        
        //SKProduct对象包含了在App Store上注册的商品的本地化信息。
        var storeProduct: SKProduct?
        for product in response.products {
            if product.productIdentifier == self.productName {
                storeProduct = product
            }
        }
        
        let payment = SKPayment(product: storeProduct!)
        print("---------------反馈信发送购买请求-------------")
        SKPaymentQueue.default().add(payment)
    }
    
    func request(_ request: SKRequest, didFailWithError error: Error) {
        SVProgressHUD.showError(withStatus: "请求商品失败")
    }
    
    func requestDidFinish(_ request: SKRequest) {
        print("---------------反馈信息结束调用-------------")
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, restoreCompletedTransactionsFailedWithError error: Error) {
        SVProgressHUD.showError(withStatus: "重复支付失败")
    }
}

extension ApplePay: SKPaymentTransactionObserver {
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            switch transaction.transactionState {
            case .purchased:
                print("----- 支付完成 --------")
                completeTransaction(transaction: transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .purchasing:
                print("----- 商品加入列表 --------")
                break
            case .restored:
                print("----- 已经购买过该商品 --------")
                restoreTransaction(transaction: transaction)
                SKPaymentQueue.default().finishTransaction(transaction)
                break
            case .failed:
                print("----- 支付失败 --------")
                failedTransaction(transaction: transaction)
                break
            default: break
            }
        }
    }
    
    func completeTransaction(transaction: SKPaymentTransaction) {
        let receiptData = NSData(contentsOf: Bundle.main.appStoreReceiptURL!)
        let encodeStr = receiptData?.base64EncodedString(options: .endLineWithLineFeed)
        let productIdentifier = transaction.payment.productIdentifier
        if !productIdentifier.isEmpty {
            validateOrder(receiptData: encodeStr!)
        } else {
            SVProgressHUD.dismiss()
        }
    }
    
    func validateOrder(receiptData: String) {
        NetworkManager.shard.requestJSONDataWithTarget(target: UserAPI.payNotice(receiptData: receiptData, outTradeNo: self.orderId)) { (status, result, message) in
            if status == .success {
                if (self.paySuccess != nil) {
                    self.paySuccess!()
                }
                SVProgressHUD.showSuccess(withStatus: "支付成功")
            } else if status == .dataError {
                SVProgressHUD.showError(withStatus: message)
            } else {
                SVProgressHUD.dismiss()
                NSObject.currentController().view.makeToast(message)
            }
        }
    }
    
    func restoreTransaction(transaction: SKPaymentTransaction) {
        // 恢复已经购买的产品
        // 移除transaction购买操作
        SKPaymentQueue.default().finishTransaction(transaction)
    }
    
    func failedTransaction(transaction: SKPaymentTransaction) {
        SKPaymentQueue.default().finishTransaction(transaction)
        SVProgressHUD.showError(withStatus: "支付失败")
    }
}

