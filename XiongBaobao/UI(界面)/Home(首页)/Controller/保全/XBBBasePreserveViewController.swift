//
//  XBBBasePreserveViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/10.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBBasePreserveViewController: WMPageController {
    
    init() {
        super.init(nibName: nil, bundle: nil)
        self.scrollEnable = false
        self.progressWidth = 30
        self.progressViewIsNaughty = true
        self.progressColor = kThemeColor
        self.titleColorNormal = kTextColor3
        self.titleColorSelected = kThemeColor
        self.menuViewStyle = .line
        self.automaticallyCalculatesItemWidths = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "保全管理"
    }
}

extension XBBBasePreserveViewController {
    override func menuView(_ menu: WMMenuView!, widthForItemAt index: Int) -> CGFloat {
        let width = super.menuView(menu, widthForItemAt: index)
        return width + 10
    }
    
    override func numbersOfChildControllers(in inpageController: WMPageController) -> Int {
        return 3
    }
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        return ["全部","图片","视频"][index]
    }
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        let vc = XBBPreserveViewController()
        vc.type = ["", "0", "1"][index]
        return vc
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect(x: 0, y: kNavHeight, width: kScreenWidth, height: kPageMenuHeight)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect(x: 0, y: kNavHeight + kPageMenuHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight - kPageMenuHeight)
    }
}
