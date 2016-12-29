//
//  CollectionBaseCell.swift
//  DYZB
//
//  Created by Raymond on 2016/12/29.
//  Copyright © 2016年 Raymond. All rights reserved.
//

import UIKit

class CollectionBaseCell: UICollectionViewCell {
    // MARK:- 控件属性
    @IBOutlet weak var sourceImageView: UIImageView!
    @IBOutlet weak var nicknameBtn: UIButton!
    @IBOutlet weak var onlineBtn: UIButton!
    
    // MARK:- 模型属性
    var anchor : AnchorModel? {
        didSet {
            // 0.检验模型是否有值
            guard let anchor = anchor else { return }
            // 1.取出在线人数显示的文字
            var onlineStr : String = ""
            if anchor.online >= 10000 {
                onlineStr = String(format: "%.1f万", Float(anchor.online) / 10000.0)
                onlineStr = onlineStr.replacingOccurrences(of: ".0", with: "")
            } else {
                onlineStr = "\(anchor.online)"
            }
            onlineBtn.setTitle(onlineStr, for: .normal)
            // 2.显示昵称
            nicknameBtn.setTitle(anchor.nickname, for: .normal)
            // 3.设置封面图片
            guard let sourceURL = URL(string: anchor.vertical_src) else { return }
            sourceImageView.kf.setImage(with: sourceURL)
        }
    }
}
