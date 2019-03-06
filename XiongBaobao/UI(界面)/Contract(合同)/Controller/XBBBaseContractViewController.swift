//
//  XBBBaseContractViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBBaseContractViewController: WMPageController {
    
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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(clickSearchItem))
    }
    
    @objc func clickSearchItem() {
        let searchVC = PYSearchViewController(hotSearches:[], searchBarPlaceholder: "搜索") { (vc, searchBar, searchText) in
            
        }
        searchVC?.showHotSearch = false
        searchVC?.searchHistoryStyle = .borderTag
        searchVC?.searchTextField.backgroundColor = kLineColor
//        searchVC?.searchTextField.corner(radius: 10, color: kTextColor9, width: kLineSize)
        let nav = XBBNavigationController.init(rootViewController: searchVC!)
        self.present(nav, animated: false, completion: nil)
    }
}

extension XBBBaseContractViewController {
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
        let vc = XBBContractPageViewController()
        vc.isProxyC = index == 1
        vc.progressWidth = 30;
        vc.progressViewIsNaughty = true
        vc.progressColor = kThemeColor
        vc.titleColorNormal = kTextColor3
        vc.titleColorSelected = kThemeColor
        vc.menuViewStyle = .line;
        vc.titleSizeNormal = 14
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
