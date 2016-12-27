//
//  HomeViewController.swift
//  DYZB
//
//  Created by Raymond on 2016/12/23.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

fileprivate let kTitleViewH : CGFloat = 40

class HomeViewController: UIViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var pageTitleView : PageTitleView = {[weak self] in
        let titleFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScrennW, height: kTitleViewH)
        let titles = ["推荐", "手游", "娱乐", "游戏", "趣玩"]
        let titleView = PageTitleView(frame: titleFrame, titles: titles)
        
        titleView.backgroundColor = UIColor.white
        titleView.delegate = self
        return titleView
    }()
    fileprivate lazy var pageContentView : PageContentView = {[weak self] in
        // 1.确定内容的 frame
        let contentH = kScrennH - kStatusBarH - kNavigationBarH - kTitleViewH
        let contentFrame = CGRect(x: 0, y: kStatusBarH + kNavigationBarH, width: kScrennW, height: contentH )
        // 2.确定所有的子控制器
        var childVcs = [UIViewController]()
        for _ in 0..<5 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(r: CGFloat(arc4random_uniform(255)), g: CGFloat(arc4random_uniform(255)), b: CGFloat(arc4random_uniform(255)))
            childVcs.append(vc)
        }
        let contentView = PageContentView(frame: contentFrame, childVcs: childVcs, parentVc: self)
        contentView.delegate = self
        return contentView
    }()
    
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI 界面
        setupUI()
        
    }
}
// MARK:- 设置 UI 界面
extension HomeViewController {
    fileprivate func setupUI() {
        // 1.设置导航栏
        setupNavigationBar()
        automaticallyAdjustsScrollViewInsets = false
        // 2.添加pageContentView
        view.addSubview(pageContentView)
        // 3.添加TitleView
        view.addSubview(pageTitleView)
    }
    // 设置导航栏
    private func setupNavigationBar() {
        // 1.设置左侧的 Item
        let btn = UIButton()
        btn.setImage(UIImage(named:"homeLogoIcon"), for: .normal)
        btn.sizeToFit()
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: btn)
        
        // 2.设置右侧的 Item
        let size = CGSize(width: 40, height: 40)
        
        let searchItem = UIBarButtonItem(imageName: "searchBtnIcon", highImageName: "searchBtnIconHL", size: size)
        let scanItem = UIBarButtonItem(imageName: "scanIcon", highImageName: "scanIconHL", size: size)
        let historyItem = UIBarButtonItem(imageName: "viewHistoryIcon", highImageName: "viewHistoryIconHL", size: size)
        let messageItem = UIBarButtonItem(imageName: "siteMessageHome", highImageName: "siteMessageHomeH", size: size)
        navigationItem.rightBarButtonItems = [searchItem, scanItem, historyItem, messageItem]
    }
}

// MARK:- 遵守PageTitleViewDelegate
extension HomeViewController : PageTitleViewDelegate{
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        pageContentView.setCurrentIndex(currentIndex: index)
    }
}

// MARK:- 遵守PageContentViewDelegate 
extension HomeViewController : PageContentViewDelegate {
    func pageContentView(contentView: PageContentView, progress: CGFloat, sourceIndex: Int, targetIndex: Int) {
        pageTitleView.setTitleWithProgress(progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

