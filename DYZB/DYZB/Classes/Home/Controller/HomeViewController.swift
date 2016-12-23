//
//  HomeViewController.swift
//  DYZB
//
//  Created by Raymond on 2016/12/23.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置导航栏的背景颜色
        navigationController?.navigationBar.barTintColor = UIColor.orange
        // 设置 UI 界面
        setupUI()
        
    }
    
    
}
// MARK:- 设置 UI 界面
extension HomeViewController {
    fileprivate func setupUI() {
        setupNavigationBar()
    }
    // 设置导航栏
    private func setupNavigationBar() {
        // 1.设置左侧的 Item
        let btn = UIButton()
        btn.setImage(UIImage(named:"homeLogoIcon"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        // 1.设置右侧的 Item
        let size = CGSize(width: 40, height: 40)
        
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
        let scanItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        let messageItem = UIBarButtonItem(imageName: "siteMessageHome", highImageName: "siteMessageHomeH", size: size)
        navigationItem.rightBarButtonItems = [searchItem, scanItem, historyItem, messageItem]
        
    }
}
