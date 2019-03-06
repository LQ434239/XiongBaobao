//
//  XBBCodeScanViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/9.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit
import AVFoundation

class XBBCodeScanViewController: XBBBaseViewController {

    private lazy var scanningView: QRCodeScanningView = {
        let view = QRCodeScanningView(frame: CGRect(x: 0, y: kNavHeight, width: kScreenWidth, height: kScreenHeight - kNavHeight))
        return view
    }()
    
    //    private lazy var manager: QRCodeScanManager = {
    //        let manager = QRCodeScanManager()
    //        manager.scanFinished = { [weak self] (result) in
    //
    //        }
    //        manager.monitorLight = { [weak self] (brightness) in
    //            print(brightness)
    //        }
    //        return manager
    //    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        xbb_setupNav()
        xbb_setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.scanningView.startTimer()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        self.scanningView.removeTimer()
    }
}

extension XBBCodeScanViewController {
    
    func xbb_setupNav() {
        self.title = "扫一扫"
    }
    
    func xbb_setupView() {
        
        self.view.backgroundColor = UIColor.clear
        
        if !NSObject.judgeSystemAuthority(type: .video) {
            return
        }
//        self.view.addSubview(self.scanningView)
//        QRCodeScanManager.shard.setupSessionPreview(preview: self.view)
    }
}
