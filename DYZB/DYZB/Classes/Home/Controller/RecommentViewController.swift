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
fileprivate let kNornamlItemH = kItemW * 3 / 4
fileprivate let kPrettyItemH = kItemW * 4 / 3
fileprivate let kHeaderViewH : CGFloat = 50

fileprivate let NomalCellID = "RecommentCellID"
fileprivate let PrettyCellID = "PrettyCellID"
fileprivate let HeaderViewID = "HeaderViewID"

// MARK:- 类
class RecommentViewController: UIViewController {
    // MARK:- 懒加载属性
    fileprivate lazy var collectionView : UICollectionView = {[weak self] in
        // 1.创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemW, height: kNornamlItemH)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScrennW, height: kHeaderViewH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: kItemMargin, bottom: 0, right: kItemMargin)
        
        // 2.创建 UICollectionView
        let collectionView = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.backgroundColor = UIColor.white
        collectionView.dataSource = self
        collectionView.delegate = self

        // 注册 cell
        collectionView.register(UINib(nibName: "NormalCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: NomalCellID)
        collectionView.register(UINib(nibName: "PrettyCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: PrettyCellID)
        // 注册组头
        collectionView.register(UINib(nibName: "HeaderCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: HeaderViewID)
        return collectionView
    }()
    fileprivate lazy var recommendVM = RecommendViewModel()
    // MARK:- 系统回调函数
    override func viewDidLoad() {
        super.viewDidLoad()
        // 设置 UI 界面
        setupUI()
        // 发送网络请求
        loadData()
    }
}

// MARK:- 设置 UI 界面
extension RecommentViewController {
    fileprivate func setupUI() {
        //添加 collectionView
        view.addSubview(collectionView)
        
    }
}

// MARK:- 发送网络请求
extension RecommentViewController {
    fileprivate func loadData() {
        recommendVM.requestData { 
            self.collectionView.reloadData()
        }
    }
}

// MARK:- UICollectionViewDataSource
extension RecommentViewController : UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendVM.anchorGroups.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let group = recommendVM.anchorGroups[section]
        return group.anchors.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.取出模型对象
        let group = recommendVM.anchorGroups[indexPath.section]
        let anchor = group.anchors[indexPath.item]
        // 2.定义 cell
        var cell : CollectionBaseCell!
        // 3.取出 cell
        if indexPath.section == 1 {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: PrettyCellID, for: indexPath) as! PrettyCollectionViewCell
        } else {
            cell = collectionView.dequeueReusableCell(withReuseIdentifier: NomalCellID, for: indexPath) as! NormalCollectionViewCell
        }
        // 4.将模型赋值给 cell
        cell.anchor = anchor
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        // 1.取出 section 的 headerView
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: HeaderViewID, for: indexPath) as! HeaderCollectionReusableView
        // 2.取出模型
        headerView.group = recommendVM.anchorGroups[indexPath.section]
        return headerView
    }
}

// MARK:- UICollectionViewDelegateFlowLayout
extension RecommentViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if  indexPath.section == 1 {
            return CGSize(width: kItemW, height: kPrettyItemH)
        }
        return CGSize(width: kItemW, height: kNornamlItemH)
    }
}
