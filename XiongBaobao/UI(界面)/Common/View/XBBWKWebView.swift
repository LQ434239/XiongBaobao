//
//  XBBWKWebView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/6.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import WebKit

@objc protocol XBBWKWebViewDelegate {
    @objc optional func didReceiveScript(message: WKScriptMessage)
    @objc optional func didFinishNavigation(webView: WKWebView)
}

class XBBWKWebView: UIView {
    
    var delegate: XBBWKWebViewDelegate?
    
    private lazy var wkWebView: WKWebView = {
        let wkWebConfig = WKWebViewConfiguration()
        let wkUController = WKUserContentController()
        wkWebConfig.userContentController = wkUController;
        wkWebConfig.allowsInlineMediaPlayback = true
        // 允许可以与网页交互，选择视图
        wkWebConfig.preferences.javaScriptEnabled = true
        wkWebConfig.preferences.javaScriptCanOpenWindowsAutomatically = true
        let jScript = "var meta = document.createElement('meta'); meta.setAttribute('name', 'viewport'); meta.setAttribute('content', 'width=device-width'); document.getElementsByTagName('head')[0].appendChild(meta);user-scalable=no"
        let wkUserScript = WKUserScript(source: jScript, injectionTime: WKUserScriptInjectionTime.atDocumentEnd, forMainFrameOnly: true)
        wkUController.addUserScript(wkUserScript)
        let wkWebView = WKWebView(frame: CGRect.zero, configuration: wkWebConfig)
        wkWebView.backgroundColor = UIColor.white
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        wkWebView.scrollView.delegate = self
        wkWebView.scrollView.bounces = false
        wkWebView.allowsBackForwardNavigationGestures = true
        wkWebView.scrollView.showsHorizontalScrollIndicator = false
        wkWebView.scrollView.showsVerticalScrollIndicator = false
        
        wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        return wkWebView
    }()
    
    private lazy var progressView: UIProgressView = {
        let progressView = UIProgressView(frame: CGRect.zero)
        progressView.tintColor = kThemeColor;
        progressView.trackTintColor = UIColor.clear
        return progressView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.wkWebView.removeObserver(self, forKeyPath: "estimatedProgress")
        self.wkWebView.configuration.userContentController.removeScriptMessageHandler(forName: "openShoot")
    }
}

extension XBBWKWebView {
    
    func setupView() {
        addSubview(self.wkWebView)
        self.wkWebView.snp.makeConstraints { (make) in
            make.edges.equalTo(self)
        }
        
        addSubview(self.progressView)
        self.progressView.snp.makeConstraints { (make) in
            make.left.top.right.equalTo(0)
            make.height.equalTo(2)
        }
    }
    
    func loadRequest(url: String) {
        let url = url.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let request = URLRequest(url: URL(string: url!)!, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        self.wkWebView.load(request)
    }
    
    func loadHTML(html: String) {
        self.wkWebView.loadHTMLString(html, baseURL: nil)
    }
    
    // MARK: KVO
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            let progress = Float(self.wkWebView.estimatedProgress)
            self.progressView.progress = progress
            if progress == 1 {
                UIView.animate(withDuration: 0.35, delay: 0.15, options: .curveEaseOut, animations: {
                    self.progressView.transform = CGAffineTransform(scaleX: 1.0, y: 1.5)
                }) { (finished) in
                    self.progressView.isHidden = true
                }
            }
        }
    }
}

extension XBBWKWebView: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        if offsetY < 0 {
            scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: false)
        }
    }
}

extension XBBWKWebView: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        self.progressView.isHidden = false
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
//        self.progressView.isHidden = true
        self.progressView.progress = 0.9
    }
    
    // 发送请求前决定是否跳转
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let url = navigationAction.request.url!
        if (navigationAction.request.url?.absoluteString.contains("weixin://wap/pay?"))! ||
            (url.scheme?.contains("tel"))!{
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [UIApplication.OpenExternalURLOptionsKey.universalLinksOnly: false], completionHandler: nil)
                decisionHandler(.cancel) // 打开新页面
                return
            }
        }
        decisionHandler(.allow)
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
        // 禁止长按弹窗
        webView.evaluateJavaScript("document.documentElement.style.webkitTouchCallout='none';", completionHandler: nil)
        self.delegate?.didFinishNavigation!(webView: webView)
    }
    
    //异常终止时调用
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}

extension XBBWKWebView: WKScriptMessageHandler {
    func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        self.delegate?.didReceiveScript!(message: message)
    }
}

extension XBBWKWebView: WKUIDelegate {
    // 提示框
    func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        NSObject.showAlertView(title: webView.url!.absoluteString, message: message, confirmTitle: "确定") { (action) in
            completionHandler()
        }
    }
    
    // 确认框
    func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        NSObject.showAlertView(title: webView.url!.absoluteString, message: message, cancelTitle: "取消", confirmTitle: "确定", cancelHandel: { (action) in
            completionHandler(false)
        }) { (action) in
            completionHandler(true)
        }
    }
    
    // 输入框
    func webView(_ webView: WKWebView, runJavaScriptTextInputPanelWithPrompt prompt: String, defaultText: String?, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (String?) -> Void) {
        let alter = UIAlertController(title: nil, message: prompt, preferredStyle: .alert)
        alter.addTextField { (textField) in
            textField.textColor = kTextColor3
            textField.placeholder = defaultText
        }
        alter.addAction(UIAlertAction(title: "确定", style: .default, handler: { (action) in
            completionHandler(alter.textFields?.last?.text)
        }))
        alter.addAction(UIAlertAction(title: "取消", style: .cancel, handler: { (action) in
            completionHandler(nil)
        }))
        NSObject.currentController().present(alter, animated: true, completion: nil)
    }
    
    //在网页上点击某些链接却不响应
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if !(navigationAction.targetFrame?.isMainFrame)! {
            webView.load(navigationAction.request)
        }
        return nil
    }
}
