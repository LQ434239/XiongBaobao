//
//  XBBShootPlayerViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/11/23.
//  Copyright © 2018 双双. All rights reserved.
//

import UIKit

class XBBShootPlayerViewController: UIViewController {

    var playerItem: AVPlayerItem?
    
    var player: AVPlayer?
    
    var playerLayer: AVPlayerLayer?
    
    var url: URL? {
        didSet {
            self.playerItem = AVPlayerItem(url: url!)
            self.player = AVPlayer(playerItem: self.playerItem)
            self.playerLayer = AVPlayerLayer(player: self.player)
            self.playerLayer!.frame = self.view.bounds
            self.playerLayer!.videoGravity = .resizeAspect
            self.view.layer.insertSublayer(self.playerLayer!, at: 0)
            self.player!.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.clear
        
        NotificationCenter.default.addObserver(self, selector: #selector(runLoopVideo(notif:)), name: .AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension XBBShootPlayerViewController {
    
    //重新播放
    @objc func runLoopVideo(notif: Notification) {
        let item: AVPlayerItem = notif.object as! AVPlayerItem
        item.seek(to: CMTime.zero)
        self.player!.play()
    }
}
