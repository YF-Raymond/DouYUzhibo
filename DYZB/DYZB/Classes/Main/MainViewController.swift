//
//  MainViewController.swift
//  DYZB
//
//  Created by Raymond on 2016/12/23.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildVc("Home")
        addChildVc("Living")
        addChildVc("Video")
        addChildVc("Focus")
        addChildVc("Mine")
    }
    
    private func addChildVc (_ storyboardName : String) {
        // 1.通过 storyboard 获取控制器
        let childVc = UIStoryboard(name: storyboardName, bundle: nil).instantiateInitialViewController()!
        // 2.将 childVc 作为子控制器
        addChildViewController(childVc)
    }
}

