//
//  NSObject+AlertView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

extension NSObject {
        
    static func showAlertView(title: String, message: String?, confirmTitle: String , confirmHandler:@escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            confirmHandler(action)
        }
        alert.addAction(confirm)
        
        NSObject.currentController().present(alert, animated: true, completion: nil)
    }
    
    static func showAlertView(title: String, message: String?, cancelTitle: String, confirmTitle: String, cancelHandel:((UIAlertAction) -> Void)? = nil, confirmHandler:@escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: cancelTitle, style: .default) { (action) in
            cancelHandel!(action)
        }
        let confirm = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            confirmHandler(action)
        }
        alert.addAction(cancel)
        alert.addAction(confirm)
        
        NSObject.currentController().present(alert, animated: true, completion: nil)
    }
    
    static func showSheetView(title: String, message: String?, actionArray: [String], atIndex:@escaping ((Int) -> Void)) {
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        for i in 0..<actionArray.count {
            let action = UIAlertAction(title: actionArray[i], style: .default, handler: { (action) in
                atIndex(i)
            })
            sheet.addAction(action)
        }
        
        sheet.addAction(UIAlertAction(title: "取消", style: .cancel, handler: nil))
        
        NSObject.currentController().present(sheet, animated: true, completion: nil)
    }
}
