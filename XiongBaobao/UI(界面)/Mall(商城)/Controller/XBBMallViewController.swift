//
//  XBBMallViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import WebKit

class XBBMallViewController: XBBBaseViewController {

    private lazy var webView: XBBWKWebView = {
        let view = XBBWKWebView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_loadWebData()
        xbb_setupView()
    }
}

extension XBBMallViewController {
    func xbb_setupView() {
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in 
            make.edges.equalTo(UIEdgeInsets(top: kNavHeight, left: 0, bottom: kTabBarHeight, right: 0))
        }
    }
    
    func xbb_loadWebData() {
        let user = UserManager.shard.read()
        let userId = user.accessToken.components(separatedBy: "_")[0]
        var userName = user.userName
        if user.userName.isEmpty {
            userName = user.phoneNumber
        }
        let requesUrl = kMallBaseURL + "?tnt=\(userId)" + "&user_name=\(userName)"
        self.webView.xbb_loadRequest(url: requesUrl)
    }
}

extension XBBMallViewController: XBBWKWebViewDelegate {
    func didFinishNavigation(webView: WKWebView) {
        self.navigationItem.title = webView.title
    }
    
    func didReceiveScript(message: WKScriptMessage) {
        let vc = XBBShootViewController()
        self.present(vc, animated: true, completion: nil)
    }
}
