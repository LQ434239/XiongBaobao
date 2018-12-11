//
//  UIImage+Extension.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/11.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

extension UIImage {
   static func image(_ color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    
    //压缩图片
    func compress() -> Data {
        //图片上传大小不能超过1M
        let maxSize = 1 * 1024 * 1024
        var quality: CGFloat = 0.9
        var imageData = self.jpegData(compressionQuality: quality)
        while (imageData?.count)! > maxSize && Int(quality) > maxSize {
            quality -= 0.1
            imageData = self.jpegData(compressionQuality: quality)
        }
        return imageData!
    }
}

