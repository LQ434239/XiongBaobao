//
//  XBBSignatureViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/7.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

protocol SignatureTopViewDelegate: NSObjectProtocol {
    func xbb_clickBackButton()
    func xbb_clickSureButton()
}

class SignatureTopView: UIView {
    
    weak var delegate: SignatureTopViewDelegate?
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "nav_back"), for: .normal)
        button.addTarget(self, action: #selector(xbb_clickBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = FontSize(14)
        label.text = "手写签名"
        label.textColor = kTextColor3
        return label
    }()
    
    private lazy var sureButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = FontSize(14)
        button.setTitle("确定", for: .normal)
        button.setTitleColor(kTextColor3, for: .normal)
        button.addTarget(self, action: #selector(xbb_clickSureButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xbb_setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func xbb_setupView() {
        self.backgroundColor = UIColor.white
        
        addSubview(self.backButton)
        self.backButton.snp.makeConstraints { (make) in
            make.left.equalTo(15 + kTopSafeSpace)
            make.top.bottom.equalTo(self)
            make.width.equalTo(30)
        }
        
        addSubview(self.titleLabel)
        self.titleLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self)
        }
        
        addSubview(self.sureButton)
        self.sureButton.snp.makeConstraints { (make) in
            make.right.equalTo(-12-kBottomSafeSpace)
            make.top.bottom.equalTo(self)
            make.width.equalTo(40)
        }
    }
    
    @objc func xbb_clickBackButton() {
        self.delegate?.xbb_clickBackButton()
    }
    
    @objc func xbb_clickSureButton() {
        self.delegate?.xbb_clickSureButton()
    }
}

protocol SignatureToolViewDelegate: NSObjectProtocol {
    func xbb_clickChangeColor(button: UIButton)
    func xbb_clickFont(button: UIButton)
    func xbb_clickReset(button: UIButton)
}

// MARK: SignatureToolView
// 画笔颜色、大小
class SignatureToolView: UIView {
    
    weak var delegate: SignatureToolViewDelegate?
    
    private lazy var blackButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = kTextColor3
        button.addTarget(self, action: #selector(xbb_clickColorButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var blueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = kThemeColor
        button.addTarget(self, action: #selector(xbb_clickColorButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var orangeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = UIColor.orange
        button.addTarget(self, action: #selector(xbb_clickColorButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var fineButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 6
        button.setImage(UIImage(named: "fine_pen"), for: .normal)
        button.addTarget(self, action: #selector(xbb_clickFontButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var coarseButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tag = 8
        button.setImage(UIImage(named: "coarse_pen"), for: .normal)
        button.addTarget(self, action: #selector(xbb_clickFontButton(button:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetButton: UIButton = {
        let button = UIButton(type: .custom)
        button.titleLabel?.font = FontSize(14)
        button.setTitle("重置", for: .normal)
        button.setTitleColor(kTextColor3, for: .normal)
        button.addTarget(self, action: #selector(xbb_clickResetButton(button:)), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        xbb_setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func xbb_setupView() {
        self.backgroundColor = UIColor.white
        addSubview(self.blackButton)
        self.blackButton.snp.makeConstraints { (make) in
            make.left.equalTo(35 + kTopSafeSpace)
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        self.blackButton.corner(radius: 12)
        
        addSubview(self.blueButton)
        self.blueButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.blackButton.snp_rightMargin).offset(CGRatioHeight(20))
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        self.blueButton.corner(radius: 12)
        
        addSubview(self.orangeButton)
        self.orangeButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.blueButton.snp_rightMargin).offset(CGRatioHeight(20))
            make.centerY.equalTo(self)
            make.size.equalTo(CGSize(width: 24, height: 24))
        }
        self.orangeButton.corner(radius: 12)
        
        addSubview(self.resetButton)
        self.resetButton.snp.makeConstraints { (make) in
            make.right.equalTo(-12-kBottomSafeSpace)
            make.top.bottom.equalTo(0)
            make.width.equalTo(40)
        }
        
        addSubview(self.coarseButton)
        self.coarseButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.resetButton.snp_leftMargin).offset(CGRatioHeight(-90))
            make.centerY.equalTo(self)
        }
        
        addSubview(self.fineButton)
        self.fineButton.snp.makeConstraints { (make) in
            make.right.equalTo(self.coarseButton.snp_leftMargin).offset(CGRatioHeight(-40))
            make.centerY.equalTo(self)
        }
    }
    
    @objc func xbb_clickColorButton(button: UIButton) {
        self.delegate?.xbb_clickChangeColor(button: button)
    }
    
    @objc func xbb_clickFontButton(button: UIButton) {
        self.delegate?.xbb_clickFont(button: button)
    }
    
    @objc func xbb_clickResetButton(button: UIButton) {
        self.delegate?.xbb_clickReset(button: button)
    }
}

// MARK: XBBSignatureViewController

typealias SignatureBlock = (_ image: UIImage, _ isDraw: Bool) -> Void

class XBBSignatureViewController: XBBBaseViewController {
    
    var signatureBlock: SignatureBlock?
    
    private lazy var topView: SignatureTopView = {
        let view = SignatureTopView()
        view.delegate = self
        return view
    }()
    
    private lazy var drawView: DrawView = {
        let view = DrawView()
        return view
    }()
    
    private lazy var toolView: SignatureToolView = {
        let view = SignatureToolView()
        view.delegate = self
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        kAppdelegate.orientationMask = .landscapeRight
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        kAppdelegate.orientationMask = .portrait
    }
}

extension XBBSignatureViewController {
    func xbb_setupView() {
        self.view.addSubview(self.topView)
        self.topView.snp.makeConstraints { (make) in
            make.left.right.top.equalTo(0)
            make.height.equalTo(40)
        }
        
        self.view.addSubview(self.toolView)
        self.toolView.snp.makeConstraints { (make) in
            make.left.right.bottom.equalTo(0)
            make.height.equalTo(50)
        }
        
        self.view.addSubview(self.drawView)
        self.drawView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(self.topView.snp_bottomMargin)
            make.bottom.equalTo(self.toolView.snp_topMargin)
        }
    }
}

extension XBBSignatureViewController: SignatureTopViewDelegate {
    func xbb_clickBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func xbb_clickSureButton() {
        if self.drawView.isDraw { 
            if self.signatureBlock != nil {
                self.signatureBlock!(self.drawView.snapshotImage(), self.drawView.isDraw)
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
}

extension XBBSignatureViewController: SignatureToolViewDelegate {
    func xbb_clickChangeColor(button: UIButton) {
        self.drawView.setPenColor(color: button.backgroundColor!)
    }
    
    func xbb_clickFont(button: UIButton) {
        self.drawView.setPenWidth(width: CGFloat(button.tag))
    }
    
    func xbb_clickReset(button: UIButton) {
        self.drawView.clearScreen()
    }
}


