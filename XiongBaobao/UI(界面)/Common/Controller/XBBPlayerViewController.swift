//
//  XBBPlayerViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/12/3.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBPlayerViewController: UIViewController {

    var requesURL: String?
    
    var player = ZFPlayerController()
    
    let controlView = ZFPlayerControlView()
    
    override func viewDidLoad() { 
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.white
        
        let playerManager = ZFAVPlayerManager()
        let player = ZFPlayerController(playerManager: playerManager, containerView: self.view)
        player.enterFullScreen(true, animated: true)
        player.controlView = self.controlView
        player.orientationWillChange = { [weak self] (player, isFullScreen) in
            if !isFullScreen {
                self?.navigationController?.popViewController(animated: false)
            }
        }
        player.allowOrentitaionRotation = false
        //"http://flv3.bn.netease.com/tvmrepo/2018/6/H/9/EDJTRBEH9/SD/EDJTRBEH9-mobile.mp4"
        player.assetURL = URL(string: self.requesURL!)!
        self.controlView.showTitle(self.title, coverURLString: nil, fullScreenMode: .landscape)
        self.player = player
    }
}

extension XBBPlayerViewController {
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return self.player.isStatusBarHidden
    }
    
    override var shouldAutorotate: Bool {
        return false
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
       return .landscape
    }
}
