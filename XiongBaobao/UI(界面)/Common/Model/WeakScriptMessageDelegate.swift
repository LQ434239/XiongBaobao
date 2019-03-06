//
//  WeakScriptMessageDelegate.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/12.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import WebKit

protocol ScriptDelegate: NSObjectProtocol {
    func xbb_userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage)
}

class WeakScriptMessageDelegate: NSObject, WKScriptMessageHandler {
    
    weak var delegate: ScriptDelegate?
    
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.delegate?.xbb_userContentController(userContentController, didReceive: message)
    }
}
