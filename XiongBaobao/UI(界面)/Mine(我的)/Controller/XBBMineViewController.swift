//
//  XBBMineViewController.swift
//  XiongBaobao
//
//  Created by 双双 on 2018/10/10.
//  Copyright © 2018年 双双. All rights reserved.
//

import UIKit

class XBBMineViewController: XBBBaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navBarBackgroundAlpha = 0
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.navigationController?.pushViewController(XBBHomeViewController(), animated: true)
    }
}
