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
    
    private func setupView() {
        self.view.backgroundColor = kWhite
        
        self.view.addSubview(self.scrollView)
        self.scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        for index in 0..<numOfPages {
            let imageView = UIImageView(image: UIImage(named: "引导页\(index + 1)"))
            scrollView.addSubview(imageView)
            imageView.snp.makeConstraints { (make) in
                make.top.bottom.equalTo(self.view)
                make.width.equalTo(KScreenWidth)
                make.left.equalTo(KScreenWidth * CGFloat(index))
            }
        }
        
        self.view.addSubview(self.pageControl)
        self.pageControl.snp.makeConstraints { (make) in
            make.bottom.equalTo(self.scrollView).offset(-kBottomSafeSpace - 10)
            make.centerX.equalTo(self.scrollView)
        }
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
        scrollView.contentSize = CGSize(width: KScreenWidth * CGFloat(numOfPages), height: KScreenHeight)
        return scrollView
    }()
    
    private lazy var startButton: UIButton = {
        let startButton = UIButton(type: .custom)
        
        return startButton
    }()
}

extension XBBGuideViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offset = scrollView.contentOffset
        // 改变pageControl的状态
        pageControl.currentPage = Int(offset.x / KScreenWidth)
        
        if pageControl.currentPage == numOfPages - 1 {
            UIView.animate(withDuration: 0.5, animations: {
                self.startButton.alpha = 1.0
            })
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.startButton.alpha = 0.0
            })
        }
    }
}

extension XBBGuideViewController {
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
