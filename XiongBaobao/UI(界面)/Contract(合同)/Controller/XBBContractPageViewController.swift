//
//  XBBContractPageViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/28.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBContractPageViewController: WMPageController {
    
    var isProxy: Bool = false //解决item分布不均
    
    var titleArray: [String] {
        if self.isProxy {
            return ["全部","待审核","待发送","待我签署","待TA签署","已完成","已拒签","已失效"]
        } else {
            return ["全部","待审核","待我签署","已完成","已拒签","已失效"]
        }
    }
    
    var statusArray: [String] {
        if self.isProxy {
            return ["","0","3","1","2","4","5","6"]
        } else {
            return ["","0","1","4","5","6"]
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _ = NotificationCenter.default.rx
        .notification(Notification.Name(rawValue: notification_refreshContract))
        .takeUntil(self.rx.deallocated) //页面销毁自动移除通知监听
        .subscribe(onNext: { notification in
            let userInfo = notification.userInfo as! [String: Int32]
            self.selectIndex = isProxyC ? userInfo["index1"]!: userInfo["index0"]!
        })
    }
}

extension XBBContractPageViewController {
    override func menuView(_ menu: WMMenuView!, widthForItemAt index: Int) -> CGFloat {
        let width = super.menuView(menu, widthForItemAt: index)
        return width + 5
    }
    
    override func numbersOfChildControllers(in inpageController: WMPageController) -> Int {
        return self.titleArray.count
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return self.titleArray[index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        let vc = XBBContractViewController()
        vc.status = statusArray[index]
        return vc
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect(x: 0, y: 0, width: kScreenWidth, height: kPageMenuHeight)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect(x: 0, y: kPageMenuHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight - kTabBarHeight - kPageMenuHeight)
    }
}

