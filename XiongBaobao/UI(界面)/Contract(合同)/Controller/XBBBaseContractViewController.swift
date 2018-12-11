//
//  XBBBaseCMViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBBaseCMViewController: WMPageController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.selectIndex = 0
        self.showOnNavigationBar = true
        self.progressColor = kThemeColor
        self.titleSizeNormal = 16;
        self.progressColor = kThemeColor
        self.titleColorNormal = kTextColor3
        self.titleColorSelected = kThemeColor
        self.automaticallyCalculatesItemWidths = true
        self.menuViewLayoutMode = .center
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension XBBBaseCMViewController {
    override func menuView(_ menu: WMMenuView!, widthForItemAt index: Int) -> CGFloat {
        let width = super.menuView(menu, widthForItemAt: index)
        return width + 20
    }
    
    override func numbersOfChildControllers(in inpageController: WMPageController) -> Int {
        return 2
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["我的合同","代理合同"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        let vc = XBBCMPageViewController()
        vc.selectedItem = index
        vc.progressWidth = 30;
        vc.progressViewIsNaughty = true
        vc.progressColor = kThemeColor;
        vc.titleColorNormal = kTextColor3;
        vc.titleColorSelected = kThemeColor;
        vc.menuViewStyle = .line
        vc.automaticallyCalculatesItemWidths = true
        return vc
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect(x: 50, y: 0, width: kScreenWidth - 100, height: kPageMenuHeight)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect(x: 0, y: kNavHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight - kTabBarHeight)
    }
}
