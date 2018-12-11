//
//  XBBContractHTMLViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/30.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBContractHTMLViewController: XBBBaseViewController {
    
    var contractModel: ContractModel?
    
    private lazy var viewModel: ContractHTMLlViewModel = {
        let viewModel = ContractHTMLlViewModel()
        return viewModel
    }()
    
    private lazy var webView: XBBWKWebView = {
        let view = XBBWKWebView()
        return view
    }()
    
    private lazy var sendButton: UIButton = {
        let button = UIButton(title: "立即发送", titleColor: UIColor.white, bgColor: kThemeColor)
        button.isHidden = true
        button.addTarget(self, action: #selector(clickSend(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var toolView: XBBSignContractToolView = {
        let view = XBBSignContractToolView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadContract()
        setupView()
    }
}

extension XBBContractHTMLViewController {
    func setupView() {
        
        self.view.backgroundColor = UIColor.white
        self.view.addSubview(self.sendButton)
        self.sendButton.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-kBottomSafeSpace)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(self.toolView)
        self.toolView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.bottom.equalTo(-kBottomSafeSpace)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(self.webView)
        self.webView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets(top: kNavHeight, left: 0, bottom: kBottomSafeSpace + 50, right: 0))
        }
    }
    
    func loadContract() {
        self.viewModel.loadContract(model: self.contractModel!) { [weak self] (model) in
            self!.contractModel! = model
            self!.sendButton.isHidden = false
            self!.webView.loadHTML(html: model.content!)
        }
    }
}

extension XBBContractHTMLViewController {
    @objc func clickSend(button: UIButton) {
        NSObject.showSheetView(title: "发送合同:", message: nil, actionArray: ["发送给个人", "发送给企业"]) { (index) in
            
        }
    }
    
    func sendContract(index: Int) {
        if (self.contractModel?.paraList?.count)! > 0 { //有参数
            let vc = XBBContractParameterViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
        }
    }
}

extension XBBContractHTMLViewController: XBBSignContractToolViewDelegate {
    func clickSign(button: UIButton) {
        let vc = XBBSignatureViewController()
//        vc.signatureBlock = { [weak self] image, isDraw in
//
//        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func clickBook(button: UIButton) {
        
    }
    
    func clickSeal(button: UIButton) {
        
    }
    
    func clickNext(button: UIButton) {
        let vc = XBBShootViewController()
        self.navigationController?.present(vc, animated: true, completion: nil)
        
    }
}
