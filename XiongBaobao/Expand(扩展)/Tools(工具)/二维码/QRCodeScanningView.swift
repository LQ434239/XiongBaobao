//
//  QRCodeScanningView.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/9.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class QRCodeScanningView: UIView {
    var borderColor: UIColor = UIColor.white  /** 边框颜色 */
    var cornerColor: UIColor = colorWithRGBA(85, 183, 55, 1) /** 边角颜色 */
    var animationTimeInterval: TimeInterval = 0.02  /** 扫描线动画时间 */
    var timer: Timer?
    
    var flag: Bool = true
    
    var isSelectedFlashlightButton: Bool = false
    
    var cornerWidth: CGFloat = 2.0  /** 边角宽度 */
    var borderX: CGFloat {
        get {
            return 0.3 * self.width / 2
        }
    }
    
    var borderY: CGFloat {
        get {
            return (self.height - borderW) / 2
        }
    }
    
    var borderW: CGFloat {
        get {
            return 0.7 * self.width
        }
    }
    
    private lazy var scanningline: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "QRCodeScanningLine"))
        imageView.frame = CGRect(x: borderX, y: borderY, width: borderW, height: 12)
        return imageView
    }()
    
    private lazy var flashButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: ""), for: .normal)
        button.center = CGPoint(x: self.width / 2, y: borderY + borderW - 40)
        button.addTarget(self, action: #selector(clickFlashButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var descLabel: UILabel = {
        let label = UILabel()
        label.font = FontSize(12)
        label.textColor = colorWithRGBA(255, 255, 255, 0.6)
        label.text = "将二维码/条码放入框内，即可自动扫描"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        
        addSubview(self.scanningline)
        
        addSubview(self.descLabel)
        self.descLabel.snp.makeConstraints { (make) in
            make.centerX.equalTo(self)
            make.top.equalTo(borderY + borderW + 30)
        }
        
        // app退到后台
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterBackground), name: UIApplication.willResignActiveNotification, object: nil)
        // app进入前台
        NotificationCenter.default.addObserver(self, selector: #selector(appWillEnterPlayGround), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        self.removeTimer()
        NotificationCenter.default.removeObserver(self)
    }
}

extension QRCodeScanningView {
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        
        let borderH = borderW
        let borderLineW: CGFloat = 0.2
        
        // 空白区域设置
        colorWithRGBA(0, 0, 0, 0.3).setFill()
        UIRectFill(rect)
        // 获取上下文，并设置混合模式
        let context = UIGraphicsGetCurrentContext()
        context!.setBlendMode(.destinationOut)
        let bezierPath = UIBezierPath(rect: CGRect(x: borderX + 0.5 * borderLineW, y: borderY + 0.5 * borderLineW, width: borderW - borderLineW, height: borderH - borderLineW))
        bezierPath.fill()
        // 执行混合模式
        context!.setBlendMode(.normal)
        
        // 边框设置
        let borderPath = UIBezierPath(rect: CGRect(x: borderX, y: borderY, width: borderW, height: borderH))
        borderPath.lineCapStyle = .butt
        borderPath.lineWidth = borderLineW
        self.borderColor.set()
        borderPath.stroke()
        
        let cornerLenght: CGFloat = 20
        // 左上角
        let leftTopPath = UIBezierPath()
        leftTopPath.lineWidth = self.cornerWidth
        self.cornerColor.set()
        leftTopPath.move(to: CGPoint(x: borderX, y: borderY + cornerLenght))
        leftTopPath.addLine(to: CGPoint(x: borderX, y: borderY))
        leftTopPath.addLine(to: CGPoint(x: borderX + cornerLenght, y: borderY))
        leftTopPath.stroke()
        
        // 左下角
        let leftBottomPath = UIBezierPath()
        leftBottomPath.lineWidth = self.cornerWidth
        self.cornerColor.set()
        leftBottomPath.move(to: CGPoint(x: borderX + cornerLenght, y: borderY + borderH))
        leftBottomPath.addLine(to: CGPoint(x: borderX, y: borderY + borderH))
        leftBottomPath.addLine(to: CGPoint(x: borderX, y: borderY + borderH - cornerLenght))
        leftBottomPath.stroke()
        
        // 右上角
        let rightTopPath = UIBezierPath()
        rightTopPath.lineWidth = self.cornerWidth
        self.cornerColor.set()
        rightTopPath.move(to: CGPoint(x: borderX + borderW - cornerLenght, y: borderY))
        rightTopPath.addLine(to: CGPoint(x: borderX + borderW, y: borderY))
        rightTopPath.addLine(to: CGPoint(x: borderX + borderW, y: borderY + cornerLenght))
        rightTopPath.stroke()
        
        // 右下角
        let rightBottomPath = UIBezierPath()
        rightBottomPath.lineWidth = self.cornerWidth
        self.cornerColor.set()
        rightBottomPath.move(to: CGPoint(x: borderX + borderW, y: borderY + borderH - cornerLenght))
        rightBottomPath.addLine(to: CGPoint(x: borderX + borderW, y: borderY + borderH))
        rightBottomPath.addLine(to: CGPoint(x: borderX + borderW - cornerLenght, y: borderY + borderH))
        rightBottomPath.stroke()
    }
}

extension QRCodeScanningView {
    func startTimer() {
        self.timer = Timer.init(timeInterval: self.animationTimeInterval, target: self, selector: #selector(beginRefresh), userInfo: nil, repeats: true)
        RunLoop.main.add(self.timer!, forMode: RunLoop.Mode.common)
    }
    
    func removeTimer() {
        self.timer?.invalidate()
        self.timer = nil
    }
    
    @objc func beginRefresh() {
        var frame = self.scanningline.frame
        
        if flag {
            frame.origin.y = borderY
            flag = false
            UIView.animate(withDuration: self.animationTimeInterval) {
                frame.origin.y += 2
                self.scanningline.frame = frame
            }
        } else {
            if self.scanningline.frame.origin.y >= borderY {
                let scanContent_MaxY = borderY + self.width - 2 * borderX
                if self.scanningline.frame.origin.y >= scanContent_MaxY - 10 {
                    frame.origin.y = borderY
                    self.scanningline.frame = frame
                    flag = true
                } else {
                    UIView.animate(withDuration: self.animationTimeInterval) {
                        frame.origin.y += 2
                        self.scanningline.frame = frame
                    }
                }
            } else {
                flag = !flag
            }
        }
    }
    
    func flashButtonStatus(brightnessValue: CGFloat) {
        if brightnessValue < 0 {
            addSubview(self.flashButton)
        } else {
            if self.isSelectedFlashlightButton == false {
                removeFlashlightButton()
            }
        }
    }
    
    func removeFlashlightButton() {
        QRCodeHelperTool.closeFlashlight()
        self.flashButton.isSelected = false
        self.isSelectedFlashlightButton = false
        self.flashButton.removeFromSuperview()
    }
    
    @objc func clickFlashButton(_ button: UIButton) {
        if button.isSelected == false {
            QRCodeHelperTool.openFlashlight()
            button.isSelected = true
            self.isSelectedFlashlightButton = true
        } else {
            removeFlashlightButton()
        }
    }
    
    @objc func appWillEnterBackground() {
        startTimer()
    }
    
    @objc func appWillEnterPlayGround() {
        removeTimer()
    }
}
