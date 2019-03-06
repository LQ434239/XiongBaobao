//
//  HTMLViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/3.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import WebKit

class XBBHTMLViewController: XBBBaseViewController {
    
    var html: String = ""
    
    var requesURL: String = ""
    
    private lazy var webView: XBBWKWebView = {
        let view = XBBWKWebView()
        return view
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_loadData()
        xbb_setupView()
    }
}

extension XBBHTMLViewController {
    
    func xbb_loadData() {
        if !self.requesURL.isEmpty {
            self.webView.xbb_loadRequest(url: self.requesURL)
        }
        
        if !self.html.isEmpty {
            self.webView.xbb_loadHTML(html: self.html)
        }
    }
    
    func xbb_setupView() {
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: kNavHeight, left: 0, bottom: 0, right: 0))
        }
    }
}
