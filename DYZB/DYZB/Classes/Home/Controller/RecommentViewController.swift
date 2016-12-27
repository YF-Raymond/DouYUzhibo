//
//  RecommentViewController.swift
//  DYZB
//
//  Created by Raymond on 2016/12/27.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit
// MARK:- 常量
fileprivate let kItemMargin : CGFloat = 10
fileprivate let kItemW = (kScrennW - 3 * kItemMargin) / 2
fileprivate let kItemH = kItemW * 3 / 4
fileprivate let kHeaderViewH : CGFloat = 50

fileprivate let NomalCellID = "RecommentCellID"
fileprivate let HeaderViewID = "HeaderViewID"

// MARK:- 类
class RecommentViewController: UIViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScrennW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建 UICollectionView
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.brown
        collectionView.dataSource = self

        // 注册 cell
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: NomalCellID)
        // 注册组头
        collectionView.register(UICollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        return collectionView
    }()
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
}

// MARK:- 设置 UI 界面
extension RecommentViewController {
    fileprivate func setupUI() {
        //添加 collectionView
        view.addSubview(collectionView)
        

    }
}

// MARK:- UICollectionViewDataSource
extension RecommentViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 12
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return 8
        } else {
            return 4
        }
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.获取 cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NomalCellID, for: indexPath)
        cell.backgroundColor = UIColor.red
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出 section 的 headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewID, for: indexPath)
        headerView.backgroundColor = UIColor.purple
        return headerView
    }
}
