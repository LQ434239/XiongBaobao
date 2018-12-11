//
//  MBProgressHUD+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/18.
//  Copyright © 2018年 双双. All rights reserved.
//

import Foundation

/*
enum HUDContentStyle {
    case defaultStyle
    case blackStyle
}

enum HUDPostion {
    case HUDPostionTop //上面
    case HUDPostionCenten //中间
    case HUDPostionBottom //下面
}

/** 成功图片 */
private let kHUDSuccessImageName = "HUD_success"
/** 失败图片 */
private let kHUDErrorImageName = "HUD_error"
/** 提示图片 */
private let kHUDInfoImageName = "HUD_info"

let kAutoHideTime = 1.5

private let kFontSize = FontSize(15)

let kFitstView: UIView = (UIApplication.shared.keyWindow?.subviews.first)!

extension MBProgressHUD {
    private static func setHUD(title: String = "", autoHidden: Bool) -> MBProgressHUD {
        self.dismiss()
        let hud = MBProgressHUD.showAdded(to: kFitstView, animated: true)
        hud.label.text = title
        hud.label.font = kFontSize
        hud.label.adjustsFontSizeToFitWidth = true
        hud.label.numberOfLines = 0
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = .blur
        hud.contentColor = UIColor.white
        hud.bezelView.backgroundColor = UIColor.black
        hud.bezelView.blurEffectStyle = .dark
        if autoHidden {
            hud.hide(animated: true, afterDelay: kAutoHideTime)
        }
        return hud
    }
    
    static func showWithStatus(_ status: String) {
        let hud = self.setHUD(title: status, autoHidden: false)
        hud.mode = .indeterminate
    }
    
    static func showLoadToView(view: UIView) -> MBProgressHUD {
        return self.setHUD(title: "", autoHidden: false)
    }
    
    static func showDown(model: MBProgressHUDMode, text: String) {
        let hud = self.setHUD(title: text, autoHidden: false)
        hud.mode = model
    }
    
    static func showText(_ text: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        hud.mode = .text
    }
    
    static func showText(text: String, detail: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        hud.detailsLabel.text = detail
        hud.mode = .text
    }
    
    static func showText(text: String, postion: HUDPostion) {
        let hud = self.setHUD(title: text, autoHidden: true)
        hud.mode = .text
        switch postion {
        case .HUDPostionTop:
            hud.offset = CGPoint(x: 0, y: -MBProgressMaxOffset)
        case .HUDPostionBottom:
            hud.offset = CGPoint(x: 0, y: MBProgressMaxOffset)
        default:
            hud.offset = CGPoint(x: 0, y: 0)
        }
    }
    
    static func showSuccessWithText(_ text: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        self.custom(hud: hud, text: text, image: kHUDSuccessImageName)
    }
    
    static func showErrorWithText(_ text: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        self.custom(hud: hud, text: text, image: kHUDErrorImageName)
    }
    
    static func showInfoWithText(_ text: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        self.custom(hud: hud, text: text, image: kHUDInfoImageName)
    }
    
    private static func custom(hud: MBProgressHUD, text: String, image: String) {
        hud.mode = .customView
        if (text.widthForFont(font: kFontSize)) <= ("最多五个字" .widthForFont(font: kFontSize)) {
            hud.isSquare = true
        }
        hud.customView = UIImageView.init(image: UIImage.init(named: image)?.withRenderingMode(.alwaysTemplate))
    }
    
    static func dismiss() {
        self.hide(for: kFitstView, animated: true)
    }
}
 */
