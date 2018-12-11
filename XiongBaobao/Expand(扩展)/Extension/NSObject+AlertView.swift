//
//  NSObject+AlertView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

extension NSObject {
    static func showAlertView(title: String, message: String, confirmTitle: String , confirmHandler:@escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let confirm = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            confirmHandler(action)
        }
        alert.addAction(confirm)
        
        NSObject.currentController().present(alert, animated: true, completion: nil)
    }
    
    static func showAlertView(title: String, message: String, confirmTitle: String, cancelTitle: String , confirmHandler:@escaping ((UIAlertAction) -> Void) , cancelHandel:@escaping ((UIAlertAction) -> Void)) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let cancel = UIAlertAction(title: cancelTitle, style: .default) { (action) in
            cancelHandel(action)
        }
        let confirm = UIAlertAction(title: confirmTitle, style: .default) { (action) in
            confirmHandler(action)
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        
        NSObject.currentController().present(alert, animated: true, completion: nil)
    }
    
    static func showSheetView(title: String, message: String, actionArray: [String], confirmTitle: String, cancelTitle: String , actionHandler:@escaping ((UIAlertAction) -> Void) , cancelHandel:@escaping ((UIAlertAction) -> Void)) {
        let sheet = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        actionArray.forEach { (item) in
            let action = UIAlertAction(title: item, style: .default, handler: { (action) in
                actionHandler(action)
            })
            sheet.addAction(action)
        }
        
        let cancel = UIAlertAction(title: cancelTitle, style: .cancel) { (action) in
            cancelHandel(action)
        }
        sheet.addAction(cancel)
        
        NSObject.currentController().present(sheet, animated: true, completion: nil)
    }
}
