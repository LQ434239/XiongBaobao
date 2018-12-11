//
//  XBBGuideViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/22.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBGuideViewController: UIViewController {

    private let numOfPages = 3

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    private lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = numOfPages
        pageControl.pageIndicatorTintColor = kTextColor9
        pageControl.currentPageIndicatorTintColor = kThemeColor
        return pageControl
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.isPagingEnabled = true
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        scrollView.bounces = false
        scrollView.contentOffset = CGPoint.zero
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: kScreenWidth * CGFloat(numOfPages), height: kScreenHeight)
        return scrollView
    }()
    
    private lazy var nowButton: UIButton = {
        let nowButton = UIButton(type: .custom)
        nowButton.setTitleColor(UIColor.white, for: .normal)
        nowButton.titleLabel?.font = FontSize(14)
        nowButton.setTitle("立即体验", for: .normal)
        nowButton.backgroundColor = UIColor(hex: "1b5495")
        nowButton.corner(radius: 15)
        nowButton.addTarget(self, action: #selector(clickNowButton), for: .touchUpInside)
        return nowButton
    }()
}

extension XBBGuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 改变pageControl的状态
        pageControl.currentPage = Int(offset.x / kScreenWidth)
    }
}

extension XBBGuideViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        for index in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "引导页\(index + 1)"))
            imageView.isUserInteractionEnabled = true
            scrollView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(self.view)
                make.width.equalTo(kScreenWidth)
                make.left.equalTo(kScreenWidth * CGFloat(index))
            }
            if index == numOfPages - 1 {
                imageView.addSubview(self.nowButton)
                self.nowButton.snp.makeConstraints { (make) in
                    make.centerX.equalTo(imageView)
                    make.bottom.equalTo(-kBottomSafeSpace-60)
                    make.size.equalTo(CGSize(width: 120, height: 30))
                }
            }
        }
        
        self.view.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.scrollView).offset(-kBottomSafeSpace - 10)
            make.centerX.equalTo(self.scrollView)
        }
    }
    
    @objc private func clickNowButton() {
        UIApplication.shared.keyWindow?.rootViewController = XBBLoginViewController()
    }
}
