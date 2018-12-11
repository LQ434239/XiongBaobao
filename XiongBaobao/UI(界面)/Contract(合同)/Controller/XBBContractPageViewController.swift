//
//  XBBCMPageViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/28.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBCMPageViewController: WMPageController {

    var selectedItem: Int = 0
    
    var titleArray: [String] {
        if self.selectedItem == 0 {
            return ["全部","待审核","待我签署","已完成","已拒签","已失效"]
        } else {
            return ["全部","待审核","待发送","待我签署","待TA签署","已完成","已拒签","已失效"]
        }
    }
    
    var stateArray: [String] {
        if self.selectedItem == 0 {
            return ["","0","1","4","5","6"]
        } else {
            return ["","0","3","1","2","4","5","6"]
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension XBBCMPageViewController {
    override func menuView(_ menu: WMMenuView!, widthForItemAt index: Int) -> CGFloat {
        let width = super.menuView(menu, widthForItemAt: index)
        return width + 10
    }
    
    override func numbersOfChildControllers(in inpageController: WMPageController) -> Int {
        return self.titleArray.count
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return self.titleArray[index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        let vc = XBBCMViewController()
        return vc
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect(x: 0, y: 0, width: kScreenWidth, height: kPageMenuHeight)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect(x: 0, y: kPageMenuHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight - kTabBarHeight - kPageMenuHeight)
    }
}

