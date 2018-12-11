//
//  UIImageView+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/8.
//  Copyright © 2018 双双. All rights reserved.
//

import Foundation

var oldframe: CGRect?

extension UIImageView {
    func scanBigImage() {
        let image = self.image
        
        let backgroundView = UIView.init(frame: kMainBounds)
        //当前imageview的原始尺寸->将像素currentImageview.bounds由currentImageview.bounds所在视图转换到目标视图window中，返回在目标视图window中的像素值
        oldframe = self.convert(self.bounds, to: keyWindow)
        backgroundView.backgroundColor = UIColor.black
        backgroundView.alpha = 0
        
        let imageView = UIImageView.init(frame: oldframe!)
        imageView.image = image
        imageView.tag = 0
        backgroundView.addSubview(imageView)
        
        keyWindow?.addSubview(backgroundView)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideImageView))
        backgroundView.addGestureRecognizer(tap)
        
        UIView.animate(withDuration: 0.4, animations: {
            let y = (kScreenHeight - (image?.size.height)! * kScreenWidth / (image?.size.width)!) / 2
            let height = (image?.size.height)! * kScreenWidth / (image?.size.width)!
            imageView.frame = CGRect(x: 0, y: y, width: kScreenWidth, height: height)
            backgroundView.alpha = 1
        }, completion: nil)
    }
    
    @objc func hideImageView(tap: UITapGestureRecognizer) {
        let view = tap.view
        let imageView = view?.viewWithTag(0)
        UIView.animate(withDuration: 0.5, animations: {
            imageView?.frame = oldframe!
            imageView?.alpha = 0
        }) { (finished) in
            view?.removeFromSuperview()
        }
    }
}
