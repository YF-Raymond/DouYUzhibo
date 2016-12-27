//
//  PageContentView.swift
//  DYZB
//
//  Created by Raymond on 2016/12/24.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

protocol PageContentViewDelegate : class {
    func pageContentView(contentView : PageContentView, progress : CGFloat, sourceIndex : Int, targetIndex : Int)
}

fileprivate let ContentCellID = "ContentCellID"

class PageContentView: UIView {
    // MARK:- 定义属性
    fileprivate var childVcs : [UIViewController]
    fileprivate weak var parentVc : UIViewController?
    fileprivate var startOffsetX : CGFloat = 0.0
    fileprivate var isForbidScrollDelegate : Bool = false
    weak var delegate : PageContentViewDelegate?
    
    // MARK:- 懒加载属性
    fileprivate lazy var collecionView : UICollectionView = {[weak self] in
        // 1.创建 layout
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        // 2.创建UICollectionView
        let collecionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: layout)
        collecionView.showsHorizontalScrollIndicator = false
        collecionView.isPagingEnabled = true
        collecionView.bounces = false
        collecionView.dataSource = self
        collecionView.delegate = self
        // 注册 cell
        collecionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: ContentCellID)
        return collecionView
    }()
    
    // MARK:- 自定义构造函数
    init(frame: CGRect, childVcs : [UIViewController], parentVc : UIViewController?) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK:- 设置 UI 界面
extension PageContentView {
    fileprivate func setupUI() {
        // 1.将所有子控制器添加到父控制器中
        for childVc in childVcs {
            parentVc?.addChildViewController(childVc)
        }
        // 2.添加UICollectionView,用于在 cell 中存放控制器的 view
        addSubview(collecionView)
        collecionView.frame = bounds
    }
}

// MARK:- UICollectionViewDataSource
extension PageContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 1.创建 cell
        let cell = collecionView.dequeueReusableCell(withReuseIdentifier: ContentCellID, for: indexPath)
        // 2.设置内容
        for view in cell.contentView.subviews {
            view.removeFromSuperview()
        }
        let childVc = childVcs[indexPath.row]
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        return cell
    }
}

// MARK:- UICollectionViewDelegate
extension PageContentView : UICollectionViewDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        isForbidScrollDelegate = false
        startOffsetX = scrollView.contentOffset.x
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        // 0.判断是否是点击事件
        if isForbidScrollDelegate {return}
        // 1.定义需要的数据
        var progress : CGFloat = 0
        var sourceIndex : Int = 0
        var targetIndex : Int = 0
        // 2.判断是左滑还是右滑
        let currentOffsetX = scrollView.contentOffset.x
        let scrollViewW = scrollView.bounds.width
        
        if currentOffsetX > startOffsetX { // 左滑
            // 1.计算progress
            progress = currentOffsetX / scrollViewW - floor( currentOffsetX / scrollViewW)
            // 2.计算sourceIndex
            sourceIndex = Int(currentOffsetX / scrollViewW)
            // 3.计算targetIndex
            targetIndex = sourceIndex + 1
            if targetIndex >= childVcs.count {
                targetIndex = childVcs.count - 1
            }
            // 4.如果完全划过去
            if currentOffsetX - startOffsetX == scrollViewW {
                progress = 1
                targetIndex = sourceIndex
            }
        } else { // 右滑
            // 1.计算progress
            progress = 1 - (currentOffsetX / scrollViewW - floor( currentOffsetX / scrollViewW))
            // 2.计算targetIndex
            targetIndex = Int(currentOffsetX / scrollViewW)
            // 3.计算sourceIndex
            sourceIndex = targetIndex + 1
            if sourceIndex >= childVcs.count {
                sourceIndex = childVcs.count - 1
            }
        }
        // 3.将progress、sourceIndex、targetIndex传给 titleView
        delegate?.pageContentView(contentView: self, progress: progress, sourceIndex: sourceIndex, targetIndex: targetIndex)
    }
}

// MARK:- 对外暴露的方法
extension PageContentView {
    func setCurrentIndex(currentIndex : Int) {
        // 1.记录需要禁止执行的代理方法
        isForbidScrollDelegate = true
        // 2.滚到正确的位置
        let offsetX = CGFloat(currentIndex) * collecionView.frame.width
        collecionView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: false)
    }
}
