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
    
    private lazy var wkWebView: WKWebView = {
        let wkWebConfig = WKWebViewConfiguration()
        let wkUController = WKUserContentController()
                wkWebConfig.userContentController = wkUController;
//        wkWebConfig.preferences.minimumFontSize = 18
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);user-scalable=no"
        let wkUserScript = WKUserScript(source: jScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        wkUController.addUserScript(wkUserScript)
        let wkWebView = WKWebView(frame: CGRect.zero, configuration: wkWebConfig)
        wkWebView.backgroundColor = UIColor.white
        wkWebView.navigationDelegate = self
        wkWebView.scrollView.delegate = self
        wkWebView.scrollView.bounces = false
        wkWebView.scrollView.showsHorizontalScrollIndicator = false
        wkWebView.scrollView.showsVerticalScrollIndicator = false
        
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return wkWebView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect(x: 0, y: kNavHeight, width: kScreenWidth, height: 2))
        progressView.tintColor = kThemeColor;
        progressView.trackTintColor = UIColor.clear
        return progressView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        setupView()
    }
    
    deinit {
        self.wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
    }
}

extension XBBHTMLViewController {
    
    func loadData() {
        if !self.requesURL.isEmpty {
            let url = self.requesURL.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
            let request = URLRequest(url: URL(string: url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
            self.wkWebView.load(request)
        }
        
        if !self.html.isEmpty {
            self.wkWebView.loadHTMLString(self.html, baseURL: nil)
        }
    }
    
    func setupView() {
        self.view.addSubview(self.wkWebView)
        self.wkWebView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: kNavHeight, left: 0, bottom: 0, right: 0))
        }

        self.view.addSubview(self.progressView)
    }
    
    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(self.wkWebView.estimatedProgress)
            self.progressView.progress = progress
            if progress == 1 {
                UIView.animate(withDuration: 0.25, delay: 0.3, options: .curveEaseOut, animations: {
                    self.progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
                }) { (finished) in
                    self.progressView.isHidden = true
                }
            }
        }
    }
}

extension XBBHTMLViewController: UIScrollViewDelegate, WKNavigationDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        self.progressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.progressView.isHidden = true
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // 禁止长按弹窗
        webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none';", completionHandler: nil)
    }
}
