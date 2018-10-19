//
//  UIView+MBProgressHUD.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/18.
//  Copyright © 2018年 双双. All rights reserved.
//

import Foundation

enum HUDContentStyle {
    case DefaultStyle //默认是白底黑字
    case BlackStyle //黑底白字
}

enum HUDPostion {
    case HUDPostionTop //上面
    case HUDPostionCenten //中间
    case HUDPostionBottom //下面
}

/** 成功图片 */
let kHUDSuccessImageName = "HUD_success"
/** 失败图片 */
let kHUDErrorImageName = "HUD_error"
/** 提示图片 */
let kHUDInfoImageName = "HUD_info"

let autoHideTime = 30.0

let kFitstView: UIView = (UIApplication.shared.keyWindow?.subviews.first)!

extension MBProgressHUD {
    private static func setHUD(title: String?, autoHidden: Bool) -> MBProgressHUD {
        let hud = MBProgressHUD.showAdded(to: kFitstView, animated: true)
        hud.label.text = title
        hud.label.font = FontSize(15)
        hud.label.adjustsFontSizeToFitWidth = true
        hud.label.numberOfLines = 0
        hud.removeFromSuperViewOnHide = true
        hud.bezelView.style = .blur;
        hud.contentColor = UIColor.white
        hud.bezelView.backgroundColor = UIColor.black
        if autoHidden {
            hud.hide(animated: true, afterDelay: autoHideTime)
        }
        return hud
    }
    
    static func showLoadToView(_ text: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        hud.mode = .indeterminate
    }
    
    static func showLoadToView(view: UIView) -> MBProgressHUD {
        return self.setHUD(title: nil, autoHidden: false)
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
        hud.mode = .customView
        hud.isSquare = true;
        hud.customView = UIImageView.init(image: UIImage.init(named: kHUDSuccessImageName)?.withRenderingMode(.alwaysTemplate))
    }
    
    static func showErrorWithText(_ text: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        hud.mode = .customView
        hud.isSquare = true;
        hud.customView = UIImageView.init(image: UIImage.init(named: kHUDErrorImageName)?.withRenderingMode(.alwaysTemplate))
    }
    
    static func showInfoWithText(_ text: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        hud.mode = .customView
        hud.isSquare = true;
        hud.customView = UIImageView.init(image: UIImage.init(named: kHUDInfoImageName)?.withRenderingMode(.alwaysTemplate))
    }
    
    static func showDown(model: MBProgressHUDMode, text: String) {
        let hud = self.setHUD(title: text, autoHidden: true)
        hud.mode = model
    }
    
    static func dismiss() {
        self.hide(for: kFitstView, animated: true)
    }
}

