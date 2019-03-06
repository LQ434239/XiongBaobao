//
//  XBBMyContractViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBMyContractViewController: WMPageController {

    var titleArray: [String] {
        return ["全部","待审核","待我签署","已完成","已拒签","已失效"]
    }
    
    var stateArray: [String] {
        return ["","0","1","4","5","6"]
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
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
        
        xbb_setupNav()
    }
}

extension XBBMyContractViewController {
    
    func xbb_setupNav() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(xbb_clickSearchItem))
    }
    
    @objc func xbb_clickSearchItem() {
        let searchVC = PYSearchViewController(hotSearches:[], searchBarPlaceholder: "搜索") { (vc, searchBar, searchText) in
            
        }
        searchVC?.showHotSearch = false
        searchVC?.searchHistoryStyle = .borderTag
        searchVC?.searchTextField.backgroundColor = kLineColor
        let nav = XBBNavigationController.init(rootViewController: searchVC!)
        self.present(nav, animated: false, completion: nil)
    }
}

extension XBBMyContractViewController {
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
        let vc = XBBContractViewController()
        return vc
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameFor menuView: WMMenuView) -> CGRect {
        return CGRect(x: 0, y: kNavHeight, width: kScreenWidth, height: kPageMenuHeight)
    }
    
    override func pageController(_ pageController: WMPageController, preferredFrameForContentView contentView: WMScrollView) -> CGRect {
        return CGRect(x: 0, y: kNavHeight + kPageMenuHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight - kTabBarHeight)
    }
}
